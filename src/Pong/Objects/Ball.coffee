define (require) ->
	{ MoveSprite } = require 'GameObject'
	Vec2 = require 'Vec2'
	Paddle = require './Paddle'
	ScoreKeeper = require './ScoreKeeper'

	class Ball extends MoveSprite

		constructor: ->
			super()
			@reset()

		reset: ->
			@angle = 0.0
			@warp Vec2.zero()
			@stopMoving()

			x = 3 + Math.random() * 3
			y = 3 + Math.random() * 3

			if Math.random() < 0.5
				x *= -1
			if Math.random() < 0.5
				y *= -1

			@accelerate new Vec2 x, y

			@timeSinceBounce = 10

		animationSize: -> [64, 64]

		speedUp: ->
			@vel().scale 1.1

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
					@timeSinceBounce = 10

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
