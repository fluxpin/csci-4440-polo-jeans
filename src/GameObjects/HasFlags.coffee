define (require) ->
	require 'meta'
	extend = (require 'jquery').extend
	CallsBack = require './CallsBack'
	Inits = require './Inits'
	GameObject = require './GameObject'
	###
	Trait: HasFlags
	Allows an object to raise and lower condition-signifying strings.
	###
	class HasFlags
		@does CallsBack, Inits

		@onInit ->
			@flags = {}

		@onDoes (user) ->
			extend user,
				###
				Class Method: onRaise
				Adds a callback for when a flag is newly raised.
				###
				onRaise: (flag, func) ->
					@onKey 'raise', flag, func

				###
				Class Method: onLower
				Adds a callback for when a flag is newly lowered.
				###
				onLower: (flag, func) ->
					@onKey 'lower', flag, func

		###
		Prop: flags
		An object whose keys are the raised flags.
		###

		###
		Method: raise
		Now <am> will respond yes to the flag.
		Calls startFlag if the flag is newly raised.
		###
		raise: (flag) ->
			unless @flags[flag]
				@flags[flag] = yes
				@callBackMap @_on_raise, flag

		###
		Method: lower
		No longer will <am> respond yes to the flag.
		Calls endFlag if the flag is newly lowered.
		###
		lower: (flag) ->
			if @flags[flag]
				delete @flags[flag]
				@callBackMap @_on_lower, flag

		###
		Method: am
		Whether the flag has been raised.
		###
		am: (flag) ->
			Object.prototype.hasOwnProperty.call @flags, flag

		###
		Method: amAny
		Whether any of the flags are raised.
		###
		amAny: (flags) ->
			flags.some @am



	describe 'flags', ->
		it 'works', ->
			class A extends GameObject
				@does HasFlags

				constructor: ->
					super()
					@timesAUp = 0
					@timesBDown = 0

				@onRaise 'a', ->
					@timesAUp += 1

				@onLower 'b', ->
					@timesBDown += 1

				test: ->
					expect(@am 'a').toEqual no
					@raise 'a'
					@raise 'b'
					expect(@timesAUp).toEqual 1
					@raise 'a'
					expect(@timesAUp).toEqual 1
					expect(@am 'a').toEqual yes
					expect(@am 'b').toEqual yes
					@lower 'b'
					expect(@am 'a').toEqual yes
					expect(@am 'b').toEqual no
					expect(@timesBDown).toEqual 1

			(new A).test()

		it 'works with traits and superclasses', ->
			class Super extends GameObject
				@does HasFlags
				@onRaise 'super', ->
					@superWorked = yes

			class Trait
				@does HasFlags
				@onRaise 'trait', ->
					@traitWorked = yes

			class Sub extends Super
				@does Trait

				@onRaise 'a', ->
					@aWorked = yes

				test: ->
					@raise 'super'
					expect(@superWorked).toEqual yes
					@raise 'trait'
					expect(@traitWorked).toEqual yes
					@raise 'a'
					expect(@aWorked).toEqual yes

			(new Sub).test()
