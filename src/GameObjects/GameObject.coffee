define (require) ->
	require 'meta'
	###
	Class: GameObject
	Anything that steps and draws.
	There are many of these per GameState.
	###
	class GameObject
		@does (require './CallsBack'), require './Inits'

		constructor: ->
			@initialize()


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
		Method: gameState
		Fetches the current GameState.
		###
		gameState: ->
			todo
			# Since only objects in the current GameState should be doing anything,
			# this should be the GameState intended for this object.

		###
		Method: the
		Fetches the Unique object of this type, if it exits.
		Otherwise returns undefined.
		###
		the: (type) ->
			@gameState.uniqueServer.the type

		die: ->
			todo
