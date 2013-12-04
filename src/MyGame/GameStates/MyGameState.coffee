define (require) ->
	{ PlayState } = require 'GameState'
	MyObject = require '../Objects/MyObject'
	Vec2 = require 'Vec2'

	class MyGameState extends PlayState
		constructor: ->
			super 512, 512

			@addObject new MyObject

			@camera.lookAt Vec2.zero()
