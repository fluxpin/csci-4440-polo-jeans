define (require) ->
	###
	A state that plays the Pong game.
	It has a ball, 2 paddles, and a score keeper.
	###
	class Pong
		###
		fill this in...
		constructor: (...) ->
			# set width = 1024, height = 512
			paddleMargin =
				32

			... new Ball
			... new Paddle paddleMargin
			... new Paddle (@width() - paddleMargin)
			... new ScoreKeeper
		###

		win: (whoWon) ->
			check (whoWon is 'wasd') or (whoWon is 'arrows')
			#go to win state


