define (require) ->
	M = require 'matrix'
	ShaderLoader = require 'Loader/ShaderLoader'
	TextureLoader = require 'Loader/TextureLoader'

	###
	Class: Graphics
	###
	class Graphics
		###
		Method: constructor
		###
		constructor: (div, width, height) ->
			type width, Number
			type height, Number

			@f = @_glFromDiv div, width, height
			# Projection and model-view matrices
			@pMatrix = M.mat4.create()
			@mvMatrix = M.mat4.create()

			@shaders = {}
			@textures = {}

		###
		Method: loadMatrices
		###
		loadMatrices: (shader) ->
			@f.uniformMatrix4fv shader.pMatrix, false, @pMatrix
			@f.uniformMatrix4fv shader.mvMatrix, false, @mvMatrix

		_glFromDiv: (div, width, height) ->
			canvas = document.createElement 'canvas'
			canvas.width = width
			canvas.height = height
			div.appendChild canvas

			gl = (canvas.getContext 'webgl') or canvas.getContext 'experimental-webgl'
			unless gl?
				throw new Error (div.innerHTML = 'Unable to initialize WebGL')
			gl.clearColor 0.0, 0.0, 0.0, 1.0
			gl.clear gl.COLOR_BUFFER_BIT
			gl

		initLoaders: ->
			shaderLoader = new ShaderLoader '/res/shaders', @
			textureLoader = new TextureLoader '/res/textures', @f
			$.when(shaderLoader.load(), textureLoader.load()).then (shad, texts) =>
				@shaders[s.name] = s for s in shad
				@textures[t.name] = t for t in texts
				@initShaders()
				@initBuffers()

		initShaders: ->
			vert = @shaders['default.vert']
			frag = @shaders['default.frag']
			@prog = @f.createProgram()

			@f.attachShader @prog, vert
			@f.attachShader @prog, frag
			@f.linkProgram @prog
			unless @f.getProgramParameter @prog, @f.LINK_STATUS
				console.log @f.getProgramInfoLog @prog
			@f.useProgram @prog

			@prog.pMatrix = @f.getUniformLocation @prog, 'p_matrix'
			@prog.mvMatrix = @f.getUniformLocation @prog, 'mv_matrix'

			@prog.vertex = @f.getAttribLocation @prog, 'vertex'
			@f.enableVertexAttribArray @prog.vertex
			@prog.aTexCoord = @f.getAttribLocation @prog, 'a_tex_coord'
			@f.enableVertexAttribArray @prog.aTexCoord

			@prog.tex = @f.getUniformLocation @prog, 'tex'

			@f.detachShader @prog, vert
			@f.detachShader @prog, frag

		initBuffers: ->
			@square = @f.createBuffer()
			@f.bindBuffer @f.ARRAY_BUFFER, @square
			@f.bufferData @f.ARRAY_BUFFER, new Float32Array([
				100.0,  100.0,
				-100.0,  100.0,
				100.0, -100.0,
				-100.0, -100.0
			]), @f.STATIC_DRAW
			@square.size = 4

			@squareTex = @f.createBuffer()
			@f.bindBuffer @f.ARRAY_BUFFER, @squareTex
			@f.bufferData @f.ARRAY_BUFFER, new Float32Array([
				1.0, 1.0,
				0.0, 1.0,
				1.0, 0.0,
				0.0, 0.0
			]), @f.STATIC_DRAW
