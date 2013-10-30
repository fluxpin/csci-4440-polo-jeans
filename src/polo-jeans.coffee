define (require) ->
	require 'jasmine'
	require 'meta'
	require 'number'

	Game = require './Game/Game'

	testGame: (div) ->
		state =
			new (require 'GameState/TestState')

		new Game div, 800, 600, state

	Game: Game
