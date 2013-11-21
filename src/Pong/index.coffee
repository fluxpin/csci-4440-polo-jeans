define (require) ->
	StartState = require './States/Start'
	#Objects = require './Objects'

	#game: (div) ->
	#	new Game div, 800, 512, new StartState
	startState: StartState
