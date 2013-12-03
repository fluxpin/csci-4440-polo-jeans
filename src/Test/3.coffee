define (require) ->
	{ PlayState } = require 'GameState'
	{ HasSounds, Sprite } = require 'GameObject'
	Player = require './Player'
	Vec2 = require 'Vec2'

	class NoiseMaker extends Sprite
		@does HasSounds

		constructor: ->
			super()

			@addSound 'win', 'res/sounds/win.ogg'
			@playSound 'win'

		animationSize: ->
			[64, 64]

		step: ->
			super()

			@eachColliding Player, =>
				@die()

			#Alternate
			#if @collides @the Player
			#	@die()



	class Test3 extends PlayState
		constructor: ->
			super 512, 512

			@addObject new NoiseMaker

			@camera.lookAt Vec2.zero()

