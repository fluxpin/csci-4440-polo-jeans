define (require) ->
	require 'meta'
	GameObject = require './GameObject'
	Graphics = require 'Render/Graphics'
	Vec2 = require 'Vec2'


	###
	Trait: HasAnimation
	Provides functions for objects that load animation data.
	TODO TEST
	###
	class HasAnimation extends GameObject
		@does require './Inits'

		###
		Method: step
		Tells my animation to step.
		###
		@onStep ->
			@animation.step()

		drawAnimation: (position, rotation) ->
			type position, Vec2
			type rotation, Number

			graphics = Graphics.instance()

			graphics.drawAt position, =>
				graphics.rotate rotation, =>
					@animation.draw()

		width: ->
			@animation.width()

		height: ->
			@animation.height()

		size: ->
			new Vec2 @width(), @height()
