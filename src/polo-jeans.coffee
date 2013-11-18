define (require) ->
	require 'jasmine'
	require 'meta'
	require 'number'

	Game = require 'Game'
	TestState = require 'GameState/TestState'

	testGame: (div) ->
		new Game div, 800, 600, new TestState
	Game: Game
