define (require) ->
	###
	Trait: HasShape
	Provides funcs for anything with a @shape
	TODO TEST
	###
	class HasShape
		###
		Method: warpTo
		Move immediately to the given destination.
		###
		warpTo: (newCenter) ->
			@shape.setCenter newCenter

		###
		Method: move
		Move by the given amount.
		Parameters:
			by - Vec of amount to move by.
		###
		move: (moveBy) ->
			@shape.move moveBy

		###
		Method: collides
		Whether I collide with it.
		Parameters:
			other - A Body I might collide with.
		###
		collides: (other) ->
			@shape.collides other.shape

		###
		Method: eachCollidingFrom
		Calls the func on each colliding body in the list.
		###
		eachCollidingFrom: (list, func) ->
			(list.filter @collides).forEach func
