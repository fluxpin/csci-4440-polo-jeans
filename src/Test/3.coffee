define (require) ->
	{ PlayState } = require 'GameState'
	GameObject = require 'GameObject'
	{ HasSounds } = GameObject
	Player = require './Player'
	Vec2 = require 'Vec2'

	class NoiseMaker extends GameObject
		@does HasSounds

		constructor: ->
			super()

			@addSound 'win', 'res/sounds/win.ogg'
			@playSound 'win'



	class Test3 extends PlayState
		constructor: ->
			super 512, 512

			@addObject new NoiseMaker

			@camera.lookAt Vec2.zero()

