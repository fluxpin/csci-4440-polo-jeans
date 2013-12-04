define (require) ->
	{ HasSounds, ListensToControl, MoveSprite } = require 'GameObject'
	Vec2 = require 'Vec2'
	Rect = require 'Rect'

	###
	Class: Paddle
	Controlled by a player, who tries to bounce the ball away from their side.
	###
	class Paddle extends MoveSprite
		@does ListensToControl, HasSounds

		###
		Constructor: Paddle

		Parameters:
			isLeft - Whether this is the left player.
			controlType - 'wasd' or 'arrows'
		###
		constructor: (isLeft, controlType) ->
			super()
			type isLeft, Boolean

			@boundRect = @_makeBoundRect isLeft
			@warp @boundRect.center()

			@_controls =
				switch controlType
					when 'wasd'
						left: 'a'
						right: 'd'
						down: 's'
						up: 'w'
					when 'arrows'
						left: 'left arrow'
						right: 'right arrow'
						down: 'down arrow'
						up: 'up arrow'
					else
						fail "Bad control type: #{controlType}"

			@addSound 'bounce', "res/sounds/bounce-#{controlType}.wav"

		animationSize: ->
			[48, 192]

		_makeBoundRect: (isLeft) ->
			marginX = 128
			marginY = 32
			top = @gameState().height()/2 - marginY
			bottom = -top

			x = @gameState().width()/2 - marginX

			[left, right] =
				if isLeft
					[-x, -marginX]
				else
					[marginX, x]

			new Rect left, bottom, right, top

		_speed: ->
			6

		###
		Method: bouncedOffOf
		Called by Ball upon bounce.
		###
		bouncedOffOf: ->
			@playSound 'bounce'

		step: ->
			super()

			@stopMoving()
			@ani 'idle'
			accs = [
				[@_controls.left, Vec2.left @_speed()],
				[@_controls.right, Vec2.right @_speed()],
				[@_controls.down, Vec2.down @_speed()],
				[@_controls.up, Vec2.up @_speed()]
			]
			accs.forEach (pair) =>
				[key, vec] = pair
				if @isButtonDown key
					@ani 'move'
					@accelerate vec

			@moveInside @boundRect
