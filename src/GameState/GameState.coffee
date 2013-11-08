define (require) ->
	Camera = require 'Camera'
	GameObject = require 'GameObject'
	UniqueServer = require './UniqueServer'

	###
	Class: GameState
	Contains the set of active GameObjects and functions to step through their
	actions and draw them.
	###
	class GameState
		constructor: ->
			@camera = new Camera
			@gameObjects = []
			@uniqueServer = new UniqueServer

		###
		Method: addobject
		Puts a new object into the play area.
		###
		addObject: (obj) ->
			type obj, GameObject
			@uniqueServer.add obj
			@gameObjects.push obj

		removeObject: (obj) ->
			todo()

		# step through a single action for all the game objects active in this
		# gamestate.
		step: ->
			@camera.step()
			@gameObjects.forEach (obj) ->
				obj.step()

			#TODO: filter out the dead

		# draws all active objects.
		draw: (gl) ->
			@camera.draw gl
			@gameObjects.forEach (obj) ->
				obj.draw gl
