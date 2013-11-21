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
		constructor: (state) ->
			GameState.current = @

			if state instanceof GameState
				@game = state.game
				@gameObjects = state.gameObjects
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
			obj

		removeObject: (obj) ->
			type obj, GameObject
			@uniqueServer.remove obj
			@gameObjects.remove obj
			obj

		step: ->

		# draws all active objects.
		draw: ->
			@camera.position()
			@gameObjects.forEach (obj) ->
				obj.draw()

		changeState: ->

		reclaimCurrent: ->
			GameState.current = @



