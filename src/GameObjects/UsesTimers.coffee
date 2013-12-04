define (require) ->
	Timer = require './Timer'

	class UsesTimers
		after: (time, event) ->
			(@the Timer).after time, event

		repeat: (time, event) ->
			(@the Timer).repeat time, event

		beAfter: (time, state) ->
			@after time, =>
				@be state

		raiseAfter: (time, flag) ->
			@after time, =>
				@raise flag

		lowerAfter: (time, flag) ->
			@after time, =>
				@lower flag
