define (require) ->
	Vec2 = require 'Vec2'
	Inits = require './Inits'
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
		warpTo: (newPos) ->
			@_pos.setTo newPos

		###
		Method: move
		Move by the given amount.
		Parameters:
			moveBy - Vec of amount to move by.
		###
		move: (moveBy) ->
			@_pos.add moveBy

		###
		Method: collides
		Whether I collide with it.
		Parameters:
			other - A Body I might collide with.
		###
		#collides: (other) ->
			#@shape.collides other.shape

		###
		Method: eachCollidingFrom
		Calls the func on each colliding body in the list.
		###
		#eachCollidingFrom: (list, func) ->
		#	(list.filter @collides).forEach func


		null
