define (require) ->
	M = require 'matrix'
	Singleton = require 'Singleton'
	Vec2 = require 'Vec2'

	###
	Class: Graphics
	Manage the WebGL context and global rendering state, and provide useful
	methods for rendering.
	###
	class Graphics extends Singleton
		###
		Method: constructor
		Parameters:
		div - A <div> element to hold the game.
		width - The width of the game in pixels.
		height - The height of the game in pixels.
		###
		constructor: (div, width, height) ->
			# WebGL context
			@context = @_glFromDiv div, width, height
			# Projection and model-view matrices
			@pMatrix = M.mat4.create()
			@mvMatrix = M.mat4.create()
			@_mvMatrixStack = []
			# Game size
			@_size = new Vec2 width, height

		###
		Method: pushMatrix
		Store the current model-view matrix before drawing.
		###
		pushMatrix: ->
			copy = M.mat4.clone @mvMatrix
			@_mvMatrixStack.push copy

		###
		Method: popMatrix
		Restore the previous model-view matrix after drawing.
		###
		popMatrix: ->
			if @_mvMatrixStack.length == 0
				fail 'Invalid popMatrix'
			@mvMatrix = @_mvMatrixStack.pop()

		###
		Method: loadMatrices
		Load the current transform matrices for rendering.
		Parameters:
		program - A shader program to be used for rendering.
		###
		loadMatrices: (program) ->
			gl = @context
			gl.uniformMatrix4fv program.pMatrix, false, @pMatrix
			gl.uniformMatrix4fv program.mvMatrix, false, @mvMatrix

		size: ->
			@_size

		###
		Method: linkProgram
		Link a vertex and fragment shader to form a shader program.
		Parameters:
		vertex - A vertex shader.
		fragment - A fragment shader.
		###
		linkProgram: (vertex, fragment) ->
			gl = @context

			program = gl.createProgram()
			gl.attachShader program, vertex
			gl.attachShader program, fragment
			gl.linkProgram program
			unless gl.getProgramParameter program, gl.LINK_STATUS
				fail gl.getProgramInfoLog program
			program

		###
		Method: drawAt
		###
		drawAt: (vec, draw) ->
			type vec, Vec2
			type draw, Function

			@_withMatrix =>
				M.mat4.translate @mvMatrix, @mvMatrix, [vec.x(), vec.y(), 0.0]
				draw()

		rotate: (angle, draw) ->
			type angle, Number
			type draw, Function

			@_withMatrix =>
				M.mat4.rotateZ @mvMatrix, @mvMatrix, angle
				draw()

		_withMatrix: (inMatrix) ->
			@pushMatrix()
			inMatrix()
			@popMatrix()

		# Create WebGL context
		_glFromDiv: (div, width, height) ->
			canvas = document.createElement 'canvas'
			canvas.width = width
			canvas.height = height
			div.appendChild canvas

			gl = (canvas.getContext 'webgl') or canvas.getContext 'experimental-webgl'
			unless gl?
				throw new Error (div.innerHTML = 'Unable to initialize WebGL')

			# Enable transparency
			gl.blendFunc gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA
			gl.enable gl.BLEND
			# Enable depth
			gl.enable gl.DEPTH_TEST
			# Clear screen to black
			gl.clearColor 0.0, 0.0, 0.0, 1.0
			# Texture coordinates increase up the Y axis, whereas image
			# coordinates increase down the Y axis.
			gl.pixelStorei gl.UNPACK_FLIP_Y_WEBGL, true
			gl.clear gl.COLOR_BUFFER_BIT
			gl
