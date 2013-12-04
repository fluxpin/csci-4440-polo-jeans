define (require) ->
	{ MoveSprite } = require 'GameObject'
	Vec2 = require 'Vec2'

	class MyObject extends MoveSprite
		constructor: ->
			super()

		animationSize: ->
			[128, 128]

		step: ->
			super()
