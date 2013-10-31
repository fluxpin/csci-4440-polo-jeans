define (require) ->
	M = require 'matrix'

	###
	Class: Camera
	###
	class Camera
		###
		Method: constructor
		###
		constructor: (@gl, @_x = 0.0, @_y = 0.0) ->

		###
		Method: step
		###
		step: ->

		###
		Method: draw
		###
		draw: ->
			@gl.f.clear @gl.f.COLOR_BUFFER_BIT
			M.mat4.identity @gl.pMatrix
			M.mat4.ortho @gl.pMatrix,
			             -@gl.f.drawingBufferWidth / 2.0,
			              @gl.f.drawingBufferWidth / 2.0,
			             -@gl.f.drawingBufferHeight / 2.0,
			              @gl.f.drawingBufferHeight / 2.0,
			             -1.0,
			              1.0
			M.mat4.identity @gl.mvMatrix
			M.mat4.translate @gl.mvMatrix, @gl.mvMatrix, [-@_x, -@_y, 0.0]

		###
		Method: lookAt
		###
		lookAt: (@_x, @_y) ->
