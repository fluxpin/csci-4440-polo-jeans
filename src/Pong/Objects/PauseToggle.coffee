define (require) ->
	GameObject = require 'GameObject'
	{ HasSounds, ListensToControl } = GameObject

	class PauseToggle extends GameObject
		@does HasSounds, ListensToControl

		constructor: ->
			super()
			@addSound 'pause','res/sounds/pause.wav'

		rotation: ->
			@angle

		@onPress 'enter', ->
			@playSound 'pause'
			@gameState().changeState()


