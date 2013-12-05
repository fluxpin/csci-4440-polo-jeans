define (require) ->
	GameObject = require './GameObject'
	Unique = require './Unique'

	class TimerEvent
		constructor: (@time, @event) ->
			type @time, Number
			type @event, Function
			null



	class Timer extends GameObject
		@does Unique

		constructor: ->
			@events = []
			@time = 0

		after: (time, event) ->
			@events.push new TimerEvent @time + time, event

			@events.sort (a, b) ->
				a.time - b.time

		repeat: (time, event) ->
			check time > 0

			x = =>
				event()
				@after time, x

			@after time, x

		step: ->
			while @events.length > 0 and @events[0].time == @time
				@events[0].event()
				@events.shift()

			@time += 1
