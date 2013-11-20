define (require) ->
	require 'meta'
	Inits = require './Inits'
	GameObject = require './GameObject'
	###
	Trait: HasSounds
	Allows an object to load and play associated sounds
	###
	class HasSounds
		@does require './Inits'

		@onInit ->
			@soundPaths = {}
			@playingSounds = {}

		###
		Method: addSound
		Takes in and stores a name and source path for a sound file
		###
		addSound: (name,source) ->
			@soundPaths[name] = source

		###
		Method: playSound
		Creates an html5 audio tag for a given sound and starts playing it
		###
		playSound: (name) ->
			@playingSounds[name] = new Audio(@soundPaths[name])
			@playingSounds[name].play()

		###
		Method: pauseSounds
		Pauses all active sounds for this GameObject
		###
		pauseSounds: ->
			for name, audio of @playingSounds
				audio.pause()

		###
		Method: unpauseSounds
		Unpauses all active sounds for this GameObject
		###
		unpauseSounds: ->
			for name, audio of @playingSounds
				audio.play()

