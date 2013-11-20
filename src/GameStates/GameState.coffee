define (require) ->
	Camera = require 'Camera'
	GameObject = require 'GameObject'
	UniqueServer = require 'GameStates/UniqueServer'

	###
	Class: GameState
	Contains the set of active GameObjects and functions to step through their
	actions and draw them.
	###
	class GameState
		constructor: (state) ->
			if arguments.length is 1
				@game = state.game
				@gameObjects = state.gameObjects
				@gameObjects.forEach (obj) =>
					if obj.gameState?
						obj.gameState = @
				@uniqueServer = state.uniqueServer
				@camera = state.camera
			else
				@camera = new Camera
				@gameObjects = []
				@uniqueServer = new UniqueServer


		###
		Method: addobject
		Puts a new object into the play area.
		###
		addObject: (obj) ->
			type obj, GameObject
			@gameObjects.push obj
			obj.gameState = @

		removeObject: (obj) ->
			type obj, GameObject
			pos = @gameObjects.indexOf obj
			if pos >= 0
				@gameObjects.splice(pos, 1)

		step: ->

		# draws all active objects.
		draw: ->
			@camera.draw()
			@gameObjects.forEach (obj) ->
				obj.draw()

		changeState: ->




