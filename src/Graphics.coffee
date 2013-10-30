define (require) ->
	ShaderLoader = require 'Loader/ShaderLoader'
	TextureLoader = require 'Loader/TextureLoader'
	M = require 'matrix'

	glFromDiv = (div, width, height) ->
		canvas = document.createElement 'canvas'
		canvas.width = width
		canvas.height = height
		div.appendChild canvas

		gl = (canvas.getContext 'webgl') or canvas.getContext 'experimental-webgl'
		unless gl?
			throw new Error (div.innerHTML = 'Unable to initialize WebGL')
		gl.clearColor 0.0, 0.0, 0.0, 1.0
		gl.clear gl.COLOR_BUFFER_BIT

		[canvas, gl]

	class Graphics
		constructor: (div, width, height) ->
			type width, Number
			type height, Number
			[@canvas, @gl] = glFromDiv div, width, height

			@shaders = { }
			@textures = { }

			# Projection, model, and view matrices
			@pMatrix = M.mat4.create()

			@mvMatrix = M.mat4.create()

		loadMatrices: (prog) ->
			@gl.uniformMatrix4fv prog.pMatrix, false, @pMatrix
			@gl.uniformMatrix4fv prog.mvMatrix, false, @mvMatrix


		initLoaders: (onAllLoaded) ->
			# What does this mean? Not 1, not 3, and 4 is absolutely out of the question!
			@sync = 2

			# TODO:
			# Why are we constructing things but not referencing them ?
			# What if @onAllLoaded is called twice?
			new ShaderLoader @gl, (shader, entry, done) =>
				#type shader, ?
				type entry, Object
				type done, Boolean
				console.log @shaders
				@shaders[entry.name] = shader
				if done
					@sync = @sync - 1
				unless @sync
					@initShaders()
					@initBuffers()
					onAllLoaded()

			new TextureLoader @gl, (texture, entry, done) =>
				@textures[entry.name] = texture
				if done
					@sync = @sync - 1
				unless @sync
					@initShaders()
					@initBuffers()
					onAllLoaded()

		initShaders: ->
			vert = @shaders['shader.vert']
			frag = @shaders['shader.frag']
			@prog = @gl.createProgram()

			@gl.attachShader @prog, vert
			@gl.attachShader @prog, frag
			@gl.linkProgram @prog
			unless @gl.getProgramParameter @prog, @gl.LINK_STATUS
				console.log @gl.getProgramInfoLog @prog
			@gl.useProgram @prog

			@prog.pMatrix = @gl.getUniformLocation @prog, 'p_matrix'
			@prog.mvMatrix = @gl.getUniformLocation @prog, 'mv_matrix'

			@prog.vertex = @gl.getAttribLocation @prog, 'vertex'
			@gl.enableVertexAttribArray @prog.vertex
			@prog.aTexCoord = @gl.getAttribLocation @prog, 'a_tex_coord'
			@gl.enableVertexAttribArray @prog.aTexCoord

			@prog.tex = @gl.getUniformLocation @prog, 'tex'

			@gl.detachShader @prog, vert
			@gl.detachShader @prog, frag

		initBuffers: ->
			@square = @gl.createBuffer()
			@gl.bindBuffer @gl.ARRAY_BUFFER, @square
			@gl.bufferData @gl.ARRAY_BUFFER, new Float32Array([
				1.0,  1.0,
				-1.0,  1.0,
				1.0, -1.0,
				-1.0, -1.0
			]), @gl.STATIC_DRAW
			@square.size = 4

			@squareTex = @gl.createBuffer()
			@gl.bindBuffer @gl.ARRAY_BUFFER, @squareTex
			@gl.bufferData @gl.ARRAY_BUFFER, new Float32Array([
				1.0, 1.0,
				0.0, 1.0,
				1.0, 0.0,
				0.0, 0.0
			]), @gl.STATIC_DRAW

		initFrame: ->
			@gl.clear @gl.COLOR_BUFFER_BIT

			M.mat4.ortho @pMatrix, 0.0, 8.0, 0.0, 6.0, -1.0, 1.0




