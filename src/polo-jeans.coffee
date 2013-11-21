define (require) ->
	require 'jasmine'
	require 'meta'
	require 'number'

	Game = require 'Game'

	testGame: (div) ->
		new Game div, 800, 512
	Game: Game
