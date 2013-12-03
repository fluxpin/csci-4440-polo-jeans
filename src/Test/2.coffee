define (require) ->
	{ PlayState } = require 'GameState'
	GameObject = require 'GameObject'
	{ Controller, ListensToControl } = GameObject
	Player = require './Player'
	Vec2 = require 'Vec2'

	class Pauser extends GameObject
		@does ListensToControl

		@onPress 'enter', ->
			(@the Player).togglePause()

	class Test2 extends PlayState
		constructor: ->
			super 512, 512

			@addObject new Controller
			@addObject new Player
			@addObject new Pauser

			@camera.lookAt Vec2.zero()
