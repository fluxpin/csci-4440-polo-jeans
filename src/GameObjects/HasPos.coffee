define (require) ->
	Vec2 = require 'Vec2'
	Inits = require './Inits'
	Rect = require 'Rect'
	###
	Trait: HasPos
	Provides funcs for anything with a @pos
	###
	class HasPos
		@does Inits

		@onInit ->
			@_pos = Vec2.zero()

		pos: ->
			@_pos

		###
		Method: warpTo
		Move immediately to the given destination.
		###
		warp: (newPos) ->
			@pos().set newPos

		###
		Method: move
		Move by the given amount.
		Parameters:
			moveBy - Vec of amount to move by.
		###
		move: (moveBy) ->
			@pos().add moveBy

		###
		Method: collides
		Whether I collide with it.
		Parameters:
			other - A HasPos I might collide with.
		###
		collides: (other) ->
			type other, HasPos
			@rect().collides other.rect()

		collideSide: (other) ->
			type other, HasPos
			@rect().collideSide other.rect()

		rect: ->
			Rect.centered @pos(), @size()

		moveInside: (rect) ->
			@pos().moveInside rect.smallerBy @size()


		###
		Method: eachColliding
		Calls the func on each colliding body in the game.
		###
		eachColliding: (type, fun) ->
			@each type, (obj) =>
				if @collides obj
					fun obj


		null
