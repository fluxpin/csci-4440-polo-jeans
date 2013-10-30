define (require) ->
	GameObject = require 'GameObject/GameObject'
	Graphics = require '../Graphics'
	UniqueServer = require './UniqueServer'

	###
	Class: GameState
	Contains the set of active GameObjects and functions to step through their
	actions and draw them.
	###
	class GameState
		constructor: ->
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

		# step through a single action for all the game objects active in this
		# gamestate.
		step: ->
			@gameObjects.forEach (obj) ->
				obj.step()

			#TODO: filter out the dead

		# draws all active objects.
		draw: (graphics) ->
			type graphics, Graphics
			@gameObjects.forEach (obj) ->
				obj.draw graphics
