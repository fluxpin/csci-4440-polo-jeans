define (require) ->
	Game = require '../Game'
	StartState = require './States/Start'

	game: (div) ->
		new Game div, 800, 512, new StartState

