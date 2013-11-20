define (require) ->
	GS = require 'GameStates/GameState'

	GS.PausedState = require 'GameStates/PausedState'
	GS.PlayState = require 'GameStates/PlayState'

	GS
