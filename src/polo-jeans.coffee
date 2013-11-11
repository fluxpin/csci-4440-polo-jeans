define (require) ->
	require 'jasmine'
	require 'meta'
	require 'number'

	Game = require 'Game'
	TestState = require 'GameState/TestState'

	testGame: (div) ->
		game = new Game div, 800, 600
		game.changeState new TestState(game)
		game
	Game: Game
