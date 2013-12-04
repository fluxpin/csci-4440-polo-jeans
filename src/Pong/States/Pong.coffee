define (require) ->
	GameState = require 'GameState'
	{ PlayState } = GameState
	Ball = require '../Objects/Ball'
	Paddle = require '../Objects/Paddle'
	Win = require './Win'
	ImageObject = require '../Objects/ImageObject'
	PauseToggle = require '../Objects/PauseToggle'
	ScoreKeeper = require '../Objects/ScoreKeeper'
	{ Controller, Timer } = require 'GameObject'

	###
	A state that plays the Pong game.
	It has a ball, 2 paddles, and a score keeper.
	###
	class Pong extends PlayState
		constructor:  (state) ->
			super 1024, 512, state
			unless state instanceof GameState
				paddleMargin = 64
				@addObject new ImageObject 'Arena.png', -3, 1024, 1024
				@addObject new Controller
				@addObject new Timer
				@addObject ball = new Ball
				@addObject new Paddle yes, 'wasd'
				@addObject new Paddle no, 'arrows'
				#bug - changeState called twice on enter if re-added here.
				#@addObject new PauseToggle
				@addObject new ScoreKeeper

		#go to win state
		win: (whoWon) ->
			@game.createState 'win', new Win whoWon
			@game.changeState 'win'

		#switch between pause and play states
		changeState: ->
			Pause = require './Pause'
			###
			#bug - no way to remove/re-add pauseimage on top without remaking state
			if @game.containsState 'pause'
				@game.changeState 'pause'
			else
			###
			@game.createState 'pause', new Pause @
			@game.changeState 'pause'
