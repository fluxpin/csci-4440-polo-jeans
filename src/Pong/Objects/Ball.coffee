define (require) ->
	{ HasFlags, HasSounds, HasState,
		MoveSprite, Timer, UsesTimers } = require 'GameObject'
	Vec2 = require 'Vec2'
	Paddle = require './Paddle'
	ScoreKeeper = require './ScoreKeeper'

	###
	Class: Ball
	Pong ball.
	###
	class Ball extends MoveSprite
		@does HasFlags, HasSounds, HasState, UsesTimers

		constructor: ->
			super()

			@addSound 'wallBounce', 'res/sounds/bounce-wall.wav'
			@addSound 'ballStart', 'res/sounds/ball-start.wav'

			@raise 'canBounce'

		animationSize: ->
			[64, 64]

		###
		Method: maxSpeed
		Stops speeding up after this speed.
		###
		maxSpeed: ->
			25

		###
		Method: speedUp
		Increases speed.
		###
		speedUp: ->
			if @vel().magnitude() < @maxSpeed()
				@vel().scale 1.1

		@onStart 'goalWait', ->
			@stopMoving()
			@beAfter 30, 'idle'

		@onStart 'idle', ->
			@angle = 0.0
			@warp Vec2.zero()
			@beAfter 30, 'move'

		@onStart 'move', ->
			x = Number.randomFrom 3, 6
			y = Number.randomFrom 3, 6

			if Math.random() < 0.5
				x *= -1
			if Math.random() < 0.5
				y *= -1

			@accelerate new Vec2 x, y

			@playSound 'ballStart'


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

			@gameState().camera.lookAt @pos()
			@gameState().camera.moveInside @gameState().rect()

			switch @state
				when 'move'
					if @am 'canBounce'
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
							@lower 'canBounce'
							@raiseAfter 20, 'canBounce'
							p.bouncedOffOf()


					gsr = @gameState().rect()

					if @rect().top() > gsr.top()
						@bounceDown()
						@playSound 'wallBounce'
					else if @rect().bottom() < gsr.bottom()
						@bounceUp()
						@playSound 'wallBounce'

					if @rect().left() < gsr.left()
						unless (@the ScoreKeeper).scoreRight()
							@be 'goalWait'
					else if @rect().right() > gsr.right()
						unless (@the ScoreKeeper).scoreLeft()
							@be 'goalWait'

		rotation: ->
			@angle
