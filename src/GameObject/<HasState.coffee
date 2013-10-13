###
Trait: HasState
A class that has a single state.
Pretty boring right now.
Starts off 'idle'.
###
class window.HasState
	@does Inits

	@listAdd 'onInit', ->
		@be 'idle'

	@onDoes (user) ->
		user.extend
			###
			Class Method: onStart
			Adds a callback for when a state is begun.
			###
			onStart: (state, func) ->
				@onKey 'starts', state, func

			###
			Class Method: onEnd
			Adds a callback for when a state ends.
			###
			onEnd: (state, func) ->
				@onKey 'ends', state, func


	###
	Prop: state
	The current state.
	###

	###
	Method: be
	Set state to something new.
	###
	be: (state) ->
		if @state != state
			@endState @state
			@state = state
			@startState @state

	startState: (state) ->
		@callBackMap @onStarts, state

	endState: (state) ->
		@callBackMap @onEnds, state


describe 'state', ->
	class SampleHasState extends GameObject
		@does HasState

		constructor: ->
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
			@be 'off'
			@toggle()
			expect(@state).toEqual 'on'
			expect(@timesOn).toEqual 1
			expect(@timesOffOff).toEqual 1
			@toggle()
			expect(@state).toEqual 'off'

	it 'works', ->
		(new SampleHasState).test()
