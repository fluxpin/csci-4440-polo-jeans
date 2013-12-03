define (require) ->
	{ ListensToControl, MoveSprite } = require 'GameObject'
	Vec2 = require 'Vec2'

	class Player extends MoveSprite
		@unique()
		@does ListensToControl

		animationSize: ->
			[128, 128]

		step: ->
			unless @paused
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

		togglePause: ->
			@paused = not @paused
