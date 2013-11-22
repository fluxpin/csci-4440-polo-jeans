define (require) ->
	GameObject = require 'GameObject'
	Counter = require './Counter'

	###
	Class: ScoreKeeper
	Tracks the score. Updates the Counters.
	Is Unique.
	###
	class ScoreKeeper extends GameObject
		@unique()

		###
		Constructor: ScoreKeeper
		###
		constructor: ->
			super()

			@left = @emit new Counter -100, 'wasd'
			@right = @emit new Counter 100, 'arrows'

		###
		Method: ScoreLeft
		One more point for the left player.
		###
		scoreLeft: ->
			@_score @left

		###
		Method: ScoreRight
		One more point for the right player.
		###
		scoreRight: ->
			@_score @right

		_score: (counter) ->
			type counter, Counter
			counter.increase()
