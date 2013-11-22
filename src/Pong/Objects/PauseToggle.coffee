define (require) ->
	GameObject = require 'GameObject'
	{ HasSounds, ListensToControl } = GameObject

	###
	Class: PauseToggle
	###
	class PauseToggle extends GameObject
		@does HasSounds, ListensToControl

		###
		Constructor: PauseToggle
		###
		constructor: ->
			super()
			@addSound 'pause', 'res/sounds/pause.wav'

		###
		Event: press 'enter'
		Pauses / unpauses.
		###
		@onPress 'enter', ->
			@playSound 'pause'
			@gameState().changeState()


