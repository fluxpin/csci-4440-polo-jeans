define (require) ->
	GameState = require 'GameState'
	ImageObject = require '../Objects/ImageObject'
	SoundPlayer = require '../Objects/SoundPlayer'
	Controller = (require 'GameObject').Controller
	Vec2 = require 'Vec2'

	###
	A state that displays that the arrow key player won
	###
	class Win extends GameState
		constructor: (whoWon) ->
			check whoWon is 'wasd' or whoWon is 'arrows'
			super 1024, 512
			imgName =
				switch whoWon
					when 'wasd'
						'WinWASD.png'
					when 'arrows'
						'WinArrows.png'
			@addObject new ImageObject imgName, 0, 512, 512
			@addObject new Controller
			@addObject new SoundPlayer 'win.ogg'
			@camera.lookAt Vec2.zero()
			@camera.moveInside @rect()

		changeState: ->
			Pong = require './Pong'
			@game.createState 'play', new Pong
			@game.changeState 'play'
