###
Class: GameState
Contains the set of active GameObjects and functions to step through their
actions and draw them.
###
class GameState
	# array of active gameObjects in this gamestate
	gameObjects: {}

	constructor: (ActiveObjects) ->
		@gameObjects = ActiveObjects

	# step through a single action for all the game objects active in this
	# gamestate.
	step: ->
		@gameObjects.forEach (x) -> x.step()

	# draws all active objects.
	draw: ->
		@gameObjects.forEach (x) -> x.draw()
