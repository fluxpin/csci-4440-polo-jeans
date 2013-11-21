define (require) ->
	GameState = require 'GameState'
	ImageObject = require '../Objects/ImageObject'
	Controller = (require 'GameObject').Controller
	Vec2 = require 'Vec2'

	###
	A state that displays that the WASD player won
	###
	class WinWASD extends GameState
		constructor: ->
			@_width = 1024
			@_height = 512
			super()
			@addObject new ImageObject 'WinWASD.png', 512, 512
			@addObject new Controller
			@camera.lookAt Vec2.zero()
			@camera.moveInside @rect()

		width: ->
			@_width
		height: ->
			@_height
