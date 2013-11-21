define (require) ->
	PlayState = (require 'GameState').PlayState
	Ball = require '../Objects/Ball'
	Paddle = require '../Objects/Paddle'
	ImageObject = require '../Objects/ImageObject'
	PauseToggle = require '../Objects/PauseToggle'
	ScoreKeeper = require '../Objects/ScoreKeeper'
	Controller = (require 'GameObject').Controller

	###
	A state that plays the Pong game.
	It has a ball, 2 paddles, and a score keeper.
	###
	class Pong extends PlayState
		constructor:  ->
			@_width = 1024
			@_height = 512
			super()

			paddleMargin = 64

			@addObject new ImageObject 'Arena.png', 1024, 1024
			@addObject new Controller
			@addObject ball = new Ball
			@addObject new Paddle (-@width()/2 + paddleMargin), 'wasd'
			@addObject new Paddle (@width()/2 - paddleMargin), 'arrows'
			@addObject new PauseToggle
			@addObject new ScoreKeeper

		width: ->
			@_width
		height: ->
			@_height

		#go to win state
		win: (whoWon) ->
			if whoWon is 'wasd'
				@game.changeState new WinWASD
			else
				@game.changeState new WinArrows

		#switch between pause and play states
		changeState: ->
			@game.changeState new Pause @
