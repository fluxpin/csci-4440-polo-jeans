define (require) ->
	{ MoveSprite, ListensToControl, HasSounds } = require 'GameObject'
	Vec2 = require 'Vec2'
	Rect = require 'Rect'

	class Paddle extends MoveSprite
		@does ListensToControl, HasSounds

		constructor: (isLeft, controlType) ->
			super()
			type isLeft, Boolean

			@boundRect = @makeBoundRect isLeft
			@warp @boundRect.center()

			@controls =
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

		makeBoundRect: (isLeft) ->
			marginX = 64
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

		speed: ->
			6

		animationSize: -> [32, 256]

		bouncedOffOf: ->
			@playSound 'bounce'


		step: ->
			super()

			@stopMoving()
			@animation.do 'idle'
			accs = [
				[@controls.left, Vec2.left @speed()],
				[@controls.right, Vec2.right @speed()],
				[@controls.down, Vec2.down @speed()],
				[@controls.up, Vec2.up @speed()]
			]
			accs.forEach (pair) =>
				[key, vec] = pair
				if @isButtonDown key
					@animation.do 'move'
					@accelerate vec

			@moveInside @boundRect
