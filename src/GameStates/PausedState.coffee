define (require) ->
	GameState = require './GameState'

	###
	Class: PausedState
	Step should not actually perform anything since the game is paused.
	Only cleanup of dead objects is done.
	###
	class PausedState extends GameState
		step: ->
			@gameObjects.forEach (obj) =>
				if obj.dead()
					@removeObject obj

		changeState: ->
			@game.changeState new PlayState @
