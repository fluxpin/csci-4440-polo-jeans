define (require) ->
	Graphics = require 'Render/Graphics'
	Animation = require 'Render/Animation'

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
			[w, h] = @animationSize()
			@animation = new Animation @animationName(), w, h
			@animation.do 'idle'

		animationName: ->
			"#{@constructor.name}.png"

		###
		Method: draw
		TODO
		Draws the animation in the right place.
		###
		draw: ->
			super()
			@drawAnimation @pos(), @rotation()

		rotation: ->
			0


