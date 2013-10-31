define (require) ->
	require 'jasmine'
	require 'meta'
	require 'number'

	Game = require 'Game'
	TestGame = require 'GameState/TestState'

	testGame: (div) ->
		new Game div, 800, 600, TestGame

	Game: Game
