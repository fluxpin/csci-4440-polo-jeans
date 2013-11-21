define (require) ->
	{ MoveSprite, ListensToControl } = require 'GameObject'
	Vec2 = require 'Vec2'

	class Paddle extends MoveSprite
		@does ListensToControl

		constructor: (x, controlType) ->
			super()

			@warp new Vec2 x, 0

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

		speed: ->
			6

		animationSize: -> [32, 256]

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
