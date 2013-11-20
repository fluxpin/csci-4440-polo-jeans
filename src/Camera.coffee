define (require) ->
	M = require 'matrix'
	Graphics = require 'Graphics'
	Vec2 = require 'Vec2'

	###
	Class: Camera
	###
	class Camera
		###
		Method: constructor
		###
		constructor: (@_x = 0.0, @_y = 0.0) ->

		###
		Method: step
		###
		step: ->

		###
		Method: draw
		###
		draw: ->
			graphics = Graphics.instance()
			gl = graphics.context

			gl.clear gl.COLOR_BUFFER_BIT
			M.mat4.identity graphics.pMatrix
			M.mat4.ortho graphics.pMatrix,
				-gl.drawingBufferWidth / 2.0,
				gl.drawingBufferWidth / 2.0,
				-gl.drawingBufferHeight / 2.0,
				gl.drawingBufferHeight / 2.0,
				-1.0,
				1.0
			M.mat4.identity graphics.mvMatrix
			M.mat4.translate graphics.mvMatrix, graphics.mvMatrix, [-@_x, -@_y, 0.0]

		###
		Method: lookAt
		###
		lookAt: (pos) ->
			type pos, Vec2
			@_x = pos.x()
			@_y = pos.y()

