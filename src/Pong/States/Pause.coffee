define (require) ->
	PausedState = require 'GameState'
	
	###
	A state that displays the pause image on top of the paused state.
	###
	class Pause extends PausedState
		constructor:  ->
			super
			@pauseImage = @addObject new imageObject pause
			
		changeState: ->
			@removeObject @pauseImage
			@game.changeState new Pong @