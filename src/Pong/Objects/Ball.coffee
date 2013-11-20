define (require) ->
	MoveSprite = (require 'GameObject').MoveSprite
	HasSounds = (require 'GameObject').HasSounds
	Vec2 = require 'Vec2'
	Paddle = require './Paddle'

	class Ball extends MoveSprite
		@does HasSounds
		constructor: ->
			super()
			@angle = 0.0
			@accelerate Vec2.right 3
			@addSound('bounce','res/sounds/bounce.wav')

		aniSize: -> [64, 64]

		step: ->
			super()
			@angle += 0.05 # 0.05 rads ~ 3 degs ~ 180 degs/s
			if @angle >= 360.0
				@angle -= 360.0

			@eachColliding Paddle, (p) =>
				@bounceX()
				@playSound('bounce')

			@gameState.camera.lookAt @pos()

		rotation: ->
			@angle
