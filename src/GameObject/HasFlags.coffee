
###
Trait: HasFlags
Allows an object to raise and lower condition signifiers.
###
class HasFlags
	init: preceder ->
		@flags = {}

	###
	Func: raise
	Now <am> will respond yes to the flag.
	###
	raise: (flag) ->
		@flags[flag] = yes

	###
	Func: lower
	No longer will <am> respond yes to the flag.
	###
	lower: (flag) ->
		@flags[flag] = no

	###
	Func: am
	Whether the flag has been raised.
	###
	am: (flag) ->
		@flags[flag] or no

	###
	Func: am_any
	Whether any of the flags are raised.
	###
	am_any: (flags) ->
		flags.some @am


describe 'flags', ->
	class SampleHasFlags
		@does HasFlags

		constructor: ->
			@init()

		test: ->
			expect(@am 'a').toEqual no
			@raise 'a'
			@raise 'b'
			expect(@am 'a').toEqual yes
			expect(@am 'b').toEqual yes
			@lower 'a'
			expect(@am 'a').toEqual no
			expect(@am 'b').toEqual yes

	it 'works', ->
		(new SampleHasFlags).test()
