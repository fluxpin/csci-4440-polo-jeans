###
Trait: Moves
Provides funcs for any Body with a @vel.
Requires a function @move.
###
class window.Moves
	###
	?
	At every step, I advance by my velocity.
	###
	#step: ->
	#	@move @vel

	###
	Method: acc
	Add the given amount to my velocity.
	###
	acc: (accelerateBy) ->
		@vel.add accelerateBy
