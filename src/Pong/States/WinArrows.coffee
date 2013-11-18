define (require) ->
	###
	A state that displays that the arrow key player won
	###
	class WinArrows extends GameState
		constructor:  ->
			super
			@addObject new imageObject WinnerArrows


