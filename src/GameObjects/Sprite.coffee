define (require) ->
	Graphics = require 'Graphics'
	Animation = require 'Animation'

	###
	Class: Sprite
	An object with an @animation that appears at its @shape.
	TODO TEST
	###
	GameObject = require './GameObject'
	HasAnimation = require './HasAnimation'
	HasPos = require './HasPos'

	class Sprite extends GameObject
		@does HasAnimation, HasPos

		@onInit ->
			aniName = "#{@constructor.name}.png"
			[w, h] = @aniSize()
			@animation = new Animation aniName, w, h
			@animation.do 'idle'

		#constructor: ->
		#	super()

		###
		Method: draw
		TODO
		Draws the animation in the right place.
		###
		draw: ->
			super()
			@animation.step()
			@drawAnimation(@pos(), @rotation())

		rotation: ->
			0


