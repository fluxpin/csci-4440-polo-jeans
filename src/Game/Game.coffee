define (require) ->
	ShaderLoader = require 'Loader/ShaderLoader'
	TextureLoader = require 'Loader/TextureLoader'
	M = require 'matrix'

	###
	Class: Game
	Initializes WebGL and manages all other necessary objects.
	###
	class Game
		shaders: {}
		textures: {}
		angle: 0
		sync: 0

		###
		Constructor: constructor
		Creates a canvas in the provided div and initializes the global WebGL
		context. Refer to the context with *gl* (eg *gl.clearColor*).

		Parameters:
		div - The id of the div where the game should be rendered.
		x - The horizontal resolution of the game.
		y - The vertical resolution of the game.
		###
		constructor: (div, x, y) ->
			div = document.getElementById div
			canvas = document.createElement 'canvas'
			canvas.width = x
			canvas.height = y
			div.appendChild canvas

			window.gl = canvas.getContext 'experimental-webgl'
			unless gl?
				throw new Error div.innerHTML = 'Unable to initialize WebGL'
			gl.clearColor 0.0, 0.0, 0.0, 1.0
			gl.clear gl.COLOR_BUFFER_BIT

		play: ->
			@sync = 2
			new ShaderLoader (shader, entry, done) =>
				@shaders[entry.name] = shader
				if done
					@sync = @sync - 1
				unless @sync
					@initShaders()
					@initBuffers()
					@tick()
			new TextureLoader (texture, entry, done) =>
				@textures[entry.name] = texture
				if done
					@sync = @sync - 1
				unless @sync
					@initShaders()
					@initBuffers()
					@tick()

		initShaders: ->
			vert = @shaders['shader.vert']
			frag = @shaders['shader.frag']
			@prog = gl.createProgram()

			gl.attachShader @prog, vert
			gl.attachShader @prog, frag
			gl.linkProgram @prog
			unless gl.getProgramParameter @prog, gl.LINK_STATUS
				console.log gl.getProgramInfoLog @prog
			gl.useProgram @prog

			@prog.pMatrix = gl.getUniformLocation @prog, 'p_matrix'
			@prog.mvMatrix = gl.getUniformLocation @prog, 'mv_matrix'

			@prog.vertex = gl.getAttribLocation @prog, 'vertex'
			gl.enableVertexAttribArray @prog.vertex
			@prog.aTexCoord = gl.getAttribLocation @prog, 'a_tex_coord'
			gl.enableVertexAttribArray @prog.aTexCoord

			@prog.tex = gl.getUniformLocation @prog, 'tex'

			gl.detachShader @prog, vert
			gl.detachShader @prog, frag

		initBuffers: ->
			@square = gl.createBuffer()
			gl.bindBuffer gl.ARRAY_BUFFER, @square
			gl.bufferData gl.ARRAY_BUFFER, new Float32Array([
				1.0,  1.0,
				-1.0,  1.0,
				1.0, -1.0,
				-1.0, -1.0
			]), gl.STATIC_DRAW
			@square.size = 4

			@squareTex = gl.createBuffer()
			gl.bindBuffer gl.ARRAY_BUFFER, @squareTex
			gl.bufferData gl.ARRAY_BUFFER, new Float32Array([
				1.0, 1.0,
				0.0, 1.0,
				1.0, 0.0,
				0.0, 0.0
			]), gl.STATIC_DRAW

		tick: =>
			try
				@angle = @angle + 0.05 # 0.05 rads ~ 3 degs ~ 180 degs/sec
				@draw()
				mozRequestAnimationFrame @tick
			catch error
				console.trace()
				throw error

		draw: ->
			gl.viewport 0, 0, gl.drawingBufferWidth, gl.drawingBufferHeight
			gl.clear gl.COLOR_BUFFER_BIT

			M.mat4.ortho pMatrix, 0.0, 8.0, 0.0, 6.0, -1.0, 1.0

			M.mat4.identity mvMatrix
			M.mat4.translate mvMatrix, mvMatrix, [4.0, 3.0, 0.0]
			M.mat4.rotateZ mvMatrix, mvMatrix, @angle
			loadMatrices @prog

			gl.bindBuffer gl.ARRAY_BUFFER, @square
			gl.vertexAttribPointer @prog.vertex, 2, gl.FLOAT, false, 0, 0
			gl.bindBuffer gl.ARRAY_BUFFER, @squareTex
			gl.vertexAttribPointer @prog.aTexCoord, 2, gl.FLOAT, false, 0, 0
			gl.activeTexture gl.TEXTURE0
			gl.bindTexture gl.TEXTURE_2D, @textures['foo.png']
			gl.uniform1i @prog.tex, 0

			gl.drawArrays gl.TRIANGLE_STRIP, 0, @square.size
