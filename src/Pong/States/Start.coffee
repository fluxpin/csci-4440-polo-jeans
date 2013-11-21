define (require) ->
	GameState = require 'GameState'
	ImageObject = require '../Objects/ImageObject'
	Controller = (require 'GameObject').Controller
	PauseToggle = require '../Objects/PauseToggle'
	Vec2 = require 'Vec2'
	
	###
	A state that displays the start screen and starts when a button is pressed.
	###
	class Start extends GameState
		constructor: ->
			@_width = 1024
			@_height = 512
			super()
			@addObject new ImageObject 'Arena.png', 1024, 1024
			@addObject new Controller
			@addObject new PauseToggle
			@camera.lookAt Vec2.zero()
			@camera.moveInside @rect()

		width: ->
			@_width
		height: ->
			@_height

		changeState: ->
			Pong = require './Pong'
			@game.createState 'pong', new Pong
			@game.changeState 'pong'