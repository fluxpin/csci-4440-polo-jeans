define (require) ->
	extend = (require 'jquery').extend
	Inits = require './Inits'
	GameObject = require './GameObject'
	###
	Trait: HasState
	A class that has a single state.
	Pretty boring right now.
	Starts off 'idle'.
	###
	class HasState
		@does Inits

		@onInit ->
			@be 'idle'

		@onDoes (user) ->
			extend user,
				###
				Class Method: onStart
				Adds a callback for when a state is begun.
				###
				onStart: (state, func) ->
					@onKey 'start', state, func

				###
				Class Method: onEnd
				Adds a callback for when a state ends.
				###
				onEnd: (state, func) ->
					@onKey 'end', state, func


		###
		Prop: state
		The current state.
		###

		###
		Method: be
		Set state to something new.
		###
		be: (state) ->
			unless @state is state
				@callBackMap @_on_end, state
				@state = state
				@callBackMap @_on_start, state

	describe 'state', ->
		class SampleHasState extends GameObject
			@does HasState

			constructor: ->
				super()
				@timesOn = 0
				@timesOffOff = 0

			toggle: ->
				switch @state
					when 'on'
						@be 'off'
					when 'off'
						@be 'on'

			@onStart 'on', ->
				@timesOn += 1

			@onEnd 'off', ->
				@timesOffOff += 1

			test: ->
				expect(@state).toEqual 'idle'
				@be 'off'
				@toggle()
				expect(@state).toEqual 'on'
				expect(@timesOn).toEqual 1
				expect(@timesOffOff).toEqual 1
				@toggle()
				expect(@state).toEqual 'off'

		it 'works', ->
			(new SampleHasState).test()
