define (require) ->
	Graphics = require 'Render/Graphics'
	Animation = require 'Render/Animation'
	Vec2 = require 'Vec2'
	GameObject = require './GameObject'
	HasAnimation = require './HasAnimation'
	HasPos = require './HasPos'

	###
	Class: Sprite
	An object with an @animation() that appears at its @pos().
	###
	class Sprite extends GameObject
		@does HasAnimation, HasPos

		###
		Event: init
		Creates my animation from animationSize and animationName.
		Has it do 'idle'.
		###
		@onInit ->
			[w, h] = @animationSize()
			@_animation = new Animation @animationName(), w, h
			@ani 'idle'

		###
		Method: animationSize
		[width, height] of animation.
		TODO: replace with option in animation index.
		###

		###
		Method: animationName
		Name of my animation.
		Defaults to class name (.png).
		###
		animationName: ->
			"#{@constructor.name}.png"

		###
		Method: draw
		Draws the animation at my position and rotation.
		###
		draw: ->
			super()
			@drawAnimation @pos(), @rotation()

		###
		Method: rotation
		How rotated to draw my animation.
		Defaults to 0.
		###
		rotation: ->
			0

		###
		Method: width
		Width of my animation.
		###
		width: ->
			@animation().width()

		###
		Method: height
		Height of my animation.
		###
		height: ->
			@animation().height()

		###
		Method: size
		###
		size: ->
			new Vec2 @width(), @height()


