define (require) ->
	require 'meta'
	GameObject = require './GameObject'
	Graphics = require 'Render/Graphics'
	Vec2 = require 'Vec2'

	###
	Trait: HasAnimation
	Provides functions for objects that have an @animation().
	###
	class HasAnimation extends GameObject
		@does require './Inits'

		###
		Event: step
		Tells my animation to step.
		###
		@onStep ->
			@animation().step()

		animation: ->
			@_animation

		###
		Method: ani
		Change my animation.
		###
		ani: (name) ->
			type name, String
			@animation().do name

		###
		Method: setLayer
		Set my animation layer.
		###
		setLayer: (layer) ->
			type layer, Number
			@animation().setLayer layer

		###
		Method: drawAnimation
		Draws my animation at the given position and rotation.
		###
		drawAnimation: (position, rotation) ->
			type position, Vec2
			type rotation, Number

			graphics = Graphics.instance()

			graphics.drawAt position, =>
				graphics.rotate rotation, =>
					@animation().draw()
