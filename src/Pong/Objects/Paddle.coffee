define (require) ->
	MoveSprite = (require 'GameObject').MoveSprite
	Vec2 = require 'Vec2'

	class Paddle extends MoveSprite
		constructor: (x) ->
			super()
			@warp new Vec2 x/2, 0

		aniSize: -> [32, 256]

		step: ->
			super()

