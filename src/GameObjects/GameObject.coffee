define ['require', 'GameState'], (require, GameState) ->
	require 'meta'
	CallsBack = require './CallsBack'
	Inits = require './Inits'

	###
	Class: GameObject
	Anything that steps and draws.
	There are many of these per GameState.
	###
	class GameObject
		@does CallsBack, Inits

		@onStep = (stepper) ->
			@on 'step', stepper

		constructor: ->
			GameState = require 'GameState'
			@_gameState = GameState.current
			@initialize()

		gameState: ->
			@_gameState

		###
		Method: step
		Runs me through a single step in the game.
		Does not involve drawing, but may make sounds.
		###
		step: ->
			@callBack @_on_step

		###
		Method: draw
		Outputs to the screen.
		###
		draw: ->

		###
		Method: the
		Fetches the Unique object of this type, if it exits.
		Otherwise returns undefined.
		###
		the: (type) ->
			@gameState().uniqueServer.the type

		dead: ->
			no

		die: ->
			@dead = -> yes

		each: (type, fun) ->
			@gameState().gameObjects.forEach (obj) ->
				if obj.isA type
					fun obj

		emit: (obj) ->
			@gameState().addObject obj
			obj
