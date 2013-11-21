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
			@stopMoving()
			@accelerate new Vec2 7, 3


		animationSize: -> [64, 64]

		step: ->
			super()
			@angle += 0.05 # 0.05 rads ~ 3 degs ~ 180 degs/s
			if @angle >= 360.0
				@angle -= 360.0

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

				p.bouncedOffOf()

			gsr = @gameState().rect()

			if @rect().top() > gsr.top()
				@bounceDown()
			else if @rect().bottom() < gsr.bottom()
				@bounceUp()

			if @rect().left() < gsr.left()
				(@the ScoreKeeper).scoreRight()
				@bounceRight()
			else if @rect().right() > gsr.right()
				(@the ScoreKeeper).scoreLeft()
				@bounceLeft()

			@gameState().camera.lookAt @pos()
			@gameState().camera.moveInside gsr

		rotation: ->
			@angle
