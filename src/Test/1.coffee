define (require) ->
	{ PlayState } = require 'GameState'
	{ Sprite } = require 'GameObject'
	Vec2 = require 'Vec2'

	class Player extends Sprite
		animationSize: ->
			[128, 128]


	class Test1 extends PlayState
		constructor: ->
			super 512, 512

			@addObject new Player

			@camera.lookAt Vec2.zero()

