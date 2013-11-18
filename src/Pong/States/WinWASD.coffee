define (require) ->
	###
	A state that displays that the WASD player won
	###
	class WinWASD extends GameState
		constructor:  ->
			super
			@addObject new imageObject winnerWASD


