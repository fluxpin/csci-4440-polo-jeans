define (require) ->
	GameObject = require 'GameObject'
	{ HasSounds } = GameObject

	###
	Class: SoundPlayer
	Plays a single sound.
	###
	class SoundPlayer extends GameObject
		@does HasSounds

		###
		Constructor: SoundPlayer

		Paremeters:
			soundName - Name of the sound to play (include extension).
		###
		constructor: (soundName) ->
			super()

			@addSound 'sound', "res/sounds/#{soundName}"
			@playSound 'sound'


