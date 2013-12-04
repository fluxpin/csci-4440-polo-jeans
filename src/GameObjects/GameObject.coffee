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

		###
		Class Method: onStep
		Adds a new thing to do every step.
		###
		@onStep = (stepper) ->
			@on 'step', stepper

		###
		Constructor: GameObject
		Sets this object's GameState to GameState.current.
		Calls all initializers.
		###
		constructor: ->
			GameState = require 'GameState'
			@_gameState = GameState.current
			@initialize()

		###
		Method: gameState
		Returns this object's gameState.
		###
		gameState: ->
			@_gameState = GameState.current

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
		Fetches the Unique object of this type.
		###
		the: (type) ->
			@gameState().uniqueServer.the type

		###
		Method: dead
		Whether the GameObject should be removed from its GameState.
		###
		dead: ->
			no

		###
		Method: die
		Become dead.
		###
		die: ->
			@dead = -> yes

		###
		Method: each
		Calls the function on every other GameObject of the given type.
		###
		each: (objType, fun) ->
			type objType, Function
			@gameState().gameObjects.forEach (obj) =>
				if (obj.isA objType) and obj isnt @
					fun obj

		###
		Method: emit
		Send my object into my GameState.
		###
		emit: (obj) ->
			@gameState().addObject obj
			obj
