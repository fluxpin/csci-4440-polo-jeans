define (require) ->
	{ PlayState } = require 'GameState'
	{ Controller, ListensToControl, MoveSprite } = require 'GameObject'
	Vec2 = require 'Vec2'

	class Player extends MoveSprite
		@unique()
		@does ListensToControl

		animationSize: ->
			[128, 128]

		step: ->
			super()

			speed = 2

			accs =
				'left arrow': Vec2.left speed
				'right arrow': Vec2.right speed
				'down arrow': Vec2.down speed
				'up arrow': Vec2.up speed

			@stopMoving()

			for button, acc of accs
				if @isButtonDown button
					@accelerate acc



	class Enemy extends MoveSprite
		constructor: ->
			super()
			@warp new Vec2 200, 0

		animationSize: ->
			[ 64, 64 ]

		step: ->
			super()

			@eachColliding Player, =>
				@die()

			#Alternate
			#if @collides @the Player
			#	@die()



	class Test4 extends PlayState
		constructor: ->
			super 512, 512

			@addObject new Controller
			@addObject new Player
			@addObject new Enemy

			@camera.lookAt Vec2.zero()
