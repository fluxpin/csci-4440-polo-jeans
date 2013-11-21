define (require) ->
	PausedState = (require 'GameState').PausedState
	ImageObject = require '../Objects/ImageObject'

	###
	A state that displays the pause image on top of the paused state.
	###
	class Pause extends PausedState
		constructor:  (state) ->
			super 1024, 512, state
			@pauseImage = @addObject new ImageObject 'Pause.png', 512, 512

		changeState: ->
			Pong = require './Pong'
			@removeObject @pauseImage
			if @game.containsState 'pong'
				@game.changeState 'pong'
			else
				@game.createState 'pong', new Pong @
				@game.changeState 'pong'














