define (require) ->
	M = require 'matrix'
	Singleton = require 'Singleton'
	Vec2 = require 'Vec2'

	###
	Class: Graphics
	###
	class Graphics extends Singleton
		###
		Method: constructor
		###
		constructor: (div, width, height) ->
			@_size = new Vec2 width, height
			@context = @_glFromDiv div, width, height
			# Projection and model-view matrices
			@pMatrix = M.mat4.create()
			@mvMatrix = M.mat4.create()
			@_mvMatrixStack = []

		size: ->
			@_size

		###
		Method: linkProgram
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
		Method: pushMatrix
		###
		pushMatrix: ->
			copy = M.mat4.clone @mvMatrix
			@_mvMatrixStack.push copy

		###
		Method: popMatrix
		###
		popMatrix: ->
			if @_mvMatrixStack.length == 0
				fail 'Invalid popMatrix'
			@mvMatrix = @_mvMatrixStack.pop()

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

		###
		Method: loadMatrices
		###
		loadMatrices: (shader) ->
			gl = @context

			gl.uniformMatrix4fv shader.pMatrix, false, @pMatrix
			gl.uniformMatrix4fv shader.mvMatrix, false, @mvMatrix

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
			#gl.enable gl.DEPTH_TEST
			# Clear screen to black
			gl.clearColor 0.0, 0.0, 0.0, 1.0
			# Texture coordinates increase up the Y axis, whereas image
			# coordinates increase down the Y axis.
			gl.pixelStorei gl.UNPACK_FLIP_Y_WEBGL, true
			gl.clear gl.COLOR_BUFFER_BIT
			gl
