define (require) ->
	require 'jasmine'
	require 'meta'
	require 'number'

	Game = require './Game/Game'

	testGame: (div) ->
		new Game div, 800, 600, 'GameState/TestState'

	Game: Game
