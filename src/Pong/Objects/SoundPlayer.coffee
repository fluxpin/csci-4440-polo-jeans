define (require) ->
	GameObject = require 'GameObject'
	{ HasSounds } = GameObject

	class SoundPlayer extends GameObject
		@does HasSounds

		constructor: (soundName) ->
			super()

			@addSound 'sound', "res/sounds/#{soundName}"
			@playSound 'sound'


