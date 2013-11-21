define (require) ->
	M = require 'matrix'
	Graphics = require 'Render/Graphics'
	Vec2 = require 'Vec2'
	GameObject = require './GameObject'
	HasPos = require './HasPos'

	###
	Class: Camera
	###
	class Camera extends GameObject
		@does HasPos

		###
		Method: constructor
		###
		constructor: (x = 0.0, y = 0.0) ->
			super()
			@initialize()
			@warp new Vec2 x, y

		size: ->
			Graphics.instance().size()

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

			M.mat4.translate graphics.mvMatrix, graphics.mvMatrix,
				[-@pos().x(), -@pos().y(), 0.0]

		###
		Method: lookAt
		###
		lookAt: (pos) ->
			type pos, Vec2
			@pos().set pos

