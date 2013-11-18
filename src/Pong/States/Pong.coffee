define (require) ->
	PlayState = require 'GameState'
	
	###
	A state that plays the Pong game.
	It has a ball, 2 paddles, and a score keeper.
	###
	class Pong extends PlayState
		constructor:  ->
			super
			
			@width = 1024
			@height = 512
			paddleMargin = 32
			
			@addObject new ImageObject background
			@addObject new Ball
			@addObject new Paddle paddleMargin
			@addObject new Paddle (@width() - paddleMargin)
			#need pause control object here
			@addObject new ScoreKeeper

		#go to win state
		win: (whoWon) ->
			if whoWon is 'wasd'
				@game.changeState new WinWASD
			else
				@game.changeState new WinArrows
		
		#switch between pause and play states
		changeState: ->
			@game.changeState new Pause @
