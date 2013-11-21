define (require) ->
	GameObject = require 'GameObject'
	Camera = GameObject.Camera
	UniqueServer = require 'GameStates/UniqueServer'
	Vec2 = require 'Vec2'
	Rect = require 'Rect'
	require 'Array'

	###
	Class: GameState
	Contains the set of active GameObjects and functions to step through their
	actions and draw them.
	###
	class GameState
		constructor: ->
			GameState.current = @

			if arguments.length is 1
				@game = state.game
				@gameObjects = state.gameObjects
				@gameObjects.forEach (obj) =>
					if obj.gameState?
						obj.gameState = @
				@uniqueServer = state.uniqueServer
				@camera = state.camera
			else
				@camera = new Camera @width(), @height()
				@gameObjects = []
				@uniqueServer = new UniqueServer

		rect: ->
			Rect.centered Vec2.zero(), new Vec2 @width(), @height()

		###
		Method: addobject
		Puts a new object into the play area.
		###
		addObject: (obj) ->
			type obj, GameObject
			@gameObjects.push obj
			@uniqueServer.add obj

		removeObject: (obj) ->
			type obj, GameObject
			@uniqueServer.remove obj
			@gameObjects.remove obj

		step: ->

		# draws all active objects.
		draw: ->
			@camera.draw()
			@gameObjects.forEach (obj) ->
				obj.draw()

		changeState: ->


