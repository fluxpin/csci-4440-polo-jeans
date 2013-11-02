define (require) ->
	extend = (require 'jquery').extend
	TraitMergingData = (require './TraitMergingData').TraitMergingData

	###
	Method: isA
	###
	Object.defineProperty Object.prototype, 'isA',
		enumerable: false
		value: (trait_ctr) ->
			(@ instanceof trait_ctr) or @traits?.contains trait_ctr.name


	###
		superPrototypes: ->
			proto =
				Object.getPrototypeOf @
			if proto?
				[proto].concat proto.superPrototypes()
			else
				[]

		superConstructors: ->
			@superPrototypes().map (x) -> x.constructor

		superNames: ->
			@superConstructors().map (x) -> x.name

		allTraitNames: ->
			if @traits?
				Object.keys @traits
			else
				[]

		allIsA: ->
			@allTraitNames().concat @superNames
	###

	###
	Func: abstract
	If the method does not exist,
	an error is thrown.
	###
	abstract = ->
		throw new AbstractNotImplementedError


	traitMembers = (trate) ->
		check typeof trate == 'function', ->
			"must be a function, not #{trate}"

		trate.prototype


	addTrait = (ctr, trait_ctr) ->
		ctr.setAdd 'traits', trait_ctr.name

	###
	Method: does
	A class that does a trait gets its methods.
	###
	Function.prototype.does = ->
		clazz =
			@prototype

		for trait_ctr in arguments
			continue if clazz.isA trait_ctr

			addTrait @, trait_ctr

			trait =
				traitMembers trait_ctr

			(Object.keys trait).forEach (name) =>
				clazz[name] =
					traitMerge @, trait_ctr, clazz[name], trait[name], name

			trait.onDoes?.data.forEach (onDoes) =>
				onDoes.call trait_ctr, @


	traitMerge = (ctr, trait_ctr, original, now, name) ->
		#return tagFrom now, trait_ctr unless original?

		tm = (x) -> x instanceof TraitMergingData
		fun = (x) -> typeof x == 'function'

		if original?
			if (tm original) and (tm now)
				original.merge now
			else if (fun original) and (fun now)
				if original == now
					now
				else
					throw new TraitCollisionError ctr, trait_ctr, name
				###
				switch now.fun_type
					#when 'preceder'
					#	(a, b, c, d, e) ->
					#		now.call(@, a, b, c, d, e)
					#		original.call(@, a, b, c, d, e)
					when 'overridable'
						original
					when undefined
						throw new TraitCollisionError ctr, trait_ctr, name
					else
						fail "Unexpected fun_type #{now.fun_type}"
				###
			else
				fail  "Can't marge #{original} with #{now}"
		else
			if tm now
				now.clone()
			else if fun now
				now.from = trait_ctr
				now
			else
				fail "Unexpected trait member #{now}"


	###
	Class: TraitCollisionError
	Thrown when a trait method (that is not a preceder or overridable)
		is also present in the user.
	###
	class TraitCollisionError extends Error
		constructor: (@class_ctr, @trait_ctr, @name) ->
			@message =
				"class #{@class_ctr.name} already has '#{@name}' " +
				"defined, doesn't need it from trait #{@trait_ctr.name}"



	###
	Class: AbstractNotImplementedError
	Thrown when an abstract method is never overridden, then called.
	###
	class AbstractNotImplementedError extends Error
		constructor: ->
			@message =
				'Function was never implemented'

	abstract: abstract
