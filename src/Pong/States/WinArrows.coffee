define (require) ->
	GameState = require 'GameState'
	ImageObject = require '../Objects/ImageObject'
	SoundPlayer = require '../Objects/SoundPlayer'
	Controller = (require 'GameObject').Controller
	Vec2 = require 'Vec2'

	###
	A state that displays that the arrow key player won
	###
	class WinArrows extends GameState
		constructor: ->
			@_width = 1024
			@_height = 512
			super()
			@addObject new ImageObject 'WinArrows.png', 512, 512
			@addObject new Controller
			@addObject new SoundPlayer 'win.ogg'
			@camera.lookAt Vec2.zero()
			@camera.moveInside @rect()

		width: ->
			@_width
		height: ->
			@_height
