define (require) ->
	GameObject = require 'GameObject'
	{ HasSounds, ListensToControl } = GameObject
	class PauseToggle extends GameObject
		@does HasSounds, ListensToControl

		constructor: ->
			super()
			@addSound 'bounce','res/sounds/bounce.wav'

		rotation: ->
			@angle

		@onPress 'enter', ->
			@gameState().changeState()


