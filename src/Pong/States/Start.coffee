define (require) ->
	PlayState = require 'GameState'

	###
	A state that displays the start screen and starts when a button is pressed.
	###
	class Start extends PlayState
		constructor:  ->
			super
			@addObject new imageObject start

		changeState: ->
			@game.changeState new Pong