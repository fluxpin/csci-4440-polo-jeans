define (require) ->
	M = require 'matrix'

	class Camera
		constructor: (@graphics) ->
			@x = 0
			@y = 0

		lookAt: (@x, @y) ->

		step: ->

		draw: ->
			@graphics.gl.clear @graphics.gl.COLOR_BUFFER_BIT
			M.mat4.identity @graphics.pMatrix
			M.mat4.ortho @graphics.pMatrix,
			             -@graphics.gl.drawingBufferWidth / 2,
			              @graphics.gl.drawingBufferWidth / 2,
			             -@graphics.gl.drawingBufferHeight / 2,
			              @graphics.gl.drawingBufferHeight / 2
			             -1.0,
			              1.0
			M.mat4.translate @graphics.mvMatrix, @graphics.mvMatrix, [-@x, -@y, 0]
