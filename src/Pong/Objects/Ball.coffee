define (require) ->
	{ MoveSprite } = require 'GameObject'
	Vec2 = require 'Vec2'
	Paddle = require './Paddle'
	ScoreKeeper = require './ScoreKeeper'

	###
	Class: Ball
	Pong ball.
	###
	class Ball extends MoveSprite
		constructor: ->
			super()
			@reset()

		###
		Method: reset
		Puts me in the center, at a random low velocity.
		###
		reset: ->
			@angle = 0.0
			@warp Vec2.zero()
			@stopMoving()

			x = Number.randomFrom 3, 6
			y = Number.randomFrom 3, 6

			if Math.random() < 0.5
				x *= -1
			if Math.random() < 0.5
				y *= -1

			@accelerate new Vec2 x, y

			@timeSinceBounce = @maxTimeSinceBounce()

		animationSize: -> [64, 64]

		###
		Method: maxTimeSinceBounce
		Doesn't bounce more than once every this many frames.
		###
		maxTimeSinceBounce: ->
			20

		###
		Method: maxSpeed
		Stops speeding up after this speed.
		###
		maxSpeed: ->
			20

		###
		Method: speedUp
		Increases speed.
		###
		speedUp: ->
			if @vel().magnitude() < @maxSpeed()
				@vel().scale 1.1

		###
		Method: step
		Rotates.
		Checks for collision with Paddles.
		Checks for collision with bounds.
		If collides with left or right side, tells the ScoreKeeper.
		###
		step: ->
			super()
			@angle += 0.05 # 0.05 rads ~ 3 degs ~ 180 degs/s
			if @angle >= 360.0
				@angle -= 360.0

			@timeSinceBounce -= 1 if @timeSinceBounce > 0

			if @timeSinceBounce == 0
				@eachColliding Paddle, (p) =>
					switch @collideSide p
						when 'left'
							@bounceRight()
						when 'right'
							@bounceLeft()
						when 'bottom'
							@bounceUp()
							@bounceUp()
						when 'top'
							@bounceDown()

					@speedUp()
					@timeSinceBounce = @maxTimeSinceBounce()

					p.bouncedOffOf()

			gsr = @gameState().rect()

			if @rect().top() > gsr.top()
				@bounceDown()
			else if @rect().bottom() < gsr.bottom()
				@bounceUp()

			@gameState().camera.lookAt @pos()
			@gameState().camera.moveInside gsr

			if @rect().left() < gsr.left()
				(@the ScoreKeeper).scoreRight()
				@reset()
			else if @rect().right() > gsr.right()
				(@the ScoreKeeper).scoreLeft()
				@reset()

		rotation: ->
			@angle
