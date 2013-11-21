define (require) ->
	M = require 'matrix'
	Graphics = require 'Render/Graphics'
	Vec2 = require 'Vec2'
	GameObject = require './GameObject'
	HasPos = require './HasPos'

	###
	Class: Camera
	Track WebGL state corresponding to various properties of the camera
	projection and provide methods for manipulating the camera.
	###
	class Camera extends GameObject
		@does HasPos

		###
		Method: constructor
		Parameters:
		x - Initial X coordinate of the camera. Optional, zero by default.
		y - Initial Y coordinate of the camera. Optional, zero by default.
		###
		constructor: (x = 0.0, y = 0.0) ->
			super()
			@initialize()
			@warp new Vec2 x, y

		size: ->
			Graphics.instance().size()

		###
		Method: position
		Position the camera for rendering the current frame.
		###
		position: ->
			graphics = Graphics.instance()
			gl = graphics.context

			# Clear the screen
			gl.clear gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT
			M.mat4.identity graphics.pMatrix
			M.mat4.identity graphics.mvMatrix

			# Calibrate and position the camera
			dx = gl.drawingBufferWidth / 2.0
			dy = gl.drawingBufferHeight / 2.0
			M.mat4.ortho graphics.pMatrix, -dx, dx, -dy, dy, -1.0, 1.0
			M.mat4.translate graphics.mvMatrix, graphics.mvMatrix,
				[-@pos().x(), -@pos().y(), 0.0]

		###
		Method: lookAt
		Move the camera to a new location.
		Parameters:
		pos - A Vec2 representing the new (X, Y) coordinates of the camera.
		###
		lookAt: (pos) ->
			type pos, Vec2
			@pos().set pos
