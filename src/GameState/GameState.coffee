define (require) ->
	Camera = require 'Camera'
	GameObject = require 'GameObject/GameObject'
	UniqueServer = require './UniqueServer'

	###
	Class: GameState
	Contains the set of active GameObjects and functions to step through their
	actions and draw them.
	###
	class GameState
		constructor: (@gl) ->
			@camera = new Camera @gl
			@gameObjects = []
			@uniqueServer = new UniqueServer
			@paused = false

		###
		Method: addobject
		Puts a new object into the play area.
		###
		addObject: (obj) ->
			type obj, GameObject
			@uniqueServer.add obj
			@gameObjects.push obj

		# switch between paused and play status
		toggle: ->
			if @paused
				@paused = false
			else
				@paused = true

		# step through a single action for all the game objects active in this
		# gamestate.
		step: ->
			if not @paused
				@camera.step()
				@gameObjects.forEach (obj) ->
					obj.step()

			#TODO: filter out the dead

		# draws all active objects.
		draw: ->
			@camera.draw()
			@gameObjects.forEach (obj) ->
				obj.draw @graphics
