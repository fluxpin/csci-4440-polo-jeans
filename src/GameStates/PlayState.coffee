define (require) ->
	GameState = require './GameState'

	###
	Class: PlayState
	The standard gamestate with both play and draw functioning on all objects.
	###
	class PlayState extends GameState
		# step through a single action for all the game objects active in this
		# gamestate.
		step: ->
			@camera.step()
			@gameObjects.forEach (obj) =>
				obj.step()
				if obj.dead()
					@removeObject obj

		changeState: ->
			@game.changeState new PausedState @
