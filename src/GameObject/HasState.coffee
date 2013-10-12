###
Trait: HasState
A class that has a single state.
Pretty boring right now.
###
class HasState
	init: preceder ->
		@state = null

	###
	Func: be
	Set state to something new.
	###
	be: (state) ->
		@state = state






describe 'state', ->
	class SampleHasState
		@does HasState

		constructor: ->
			@init()

		toggle: ->
			switch @state
				when 'on'
					@be 'off'
				when 'off'
					@be 'on'

		test: ->
			@be 'off'
			@toggle()
			expect(@state).toEqual 'on'
			@toggle()
			expect(@state).toEqual 'off'

	it 'works', ->
		(new SampleHasState).test()
