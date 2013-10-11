set_fun_type = (fun, type) ->
	check not fun.fun_type?, ->
		"tried to set fun of type #{fun.fun_type} to #{type}"
	fun.fun_type = type
	fun

###
Func: preceder
If there is a method conflict,
	the trait's preceder method will take place *before*
	the user's version of the same.
###
window.preceder = (fun) ->
	set_fun_type fun, 'preceder'

###
Func: overridable
If there is a method conflict,
	the trait's overridable method will be ignored.
###
window.overridable = (fun) ->
	set_fun_type fun, 'overridable'

trait_members = (trate) ->
	check typeof trate == 'function', ->
		"must be a function, not #{trate}"

	trate.prototype

###
Func: does
A class that <does> a trait gets its methods.
###
Function.prototype.does = (trait_ctr) ->
	clazz =
		@prototype
	trate =
		trait_members trait_ctr

	for name in Object.keys trate
		clazz[name] =
			if clazz[name]?
				original =
					clazz[name]
				now =
					trate[name]

				switch now.fun_type
					when undefined
						throw new TraitCollisionError clazz, trate, name
					when 'preceder'
						(a, b, c, d, e) ->
							now.call(this, a, b, c, d, e)
							original.call(this, a, b, c, d, e)
					when 'overridable'
						original

			else
				trate[name]

###
Class: TraitCollisionError
Thrown when a trait method (that is not a preceder or overridable)
	is also present in the user.
###
class window.TraitCollisionError extends Error
	constructor: (@clazz, @trate, @name) ->
		@message =
			"class #{clazz.name} already has property #{@name} in trait {@trate.name}"



if TEST
	class A
		init: preceder ->
			@a = 1

		twice_a: ->
			@a * 2

	class B
		init: preceder ->
			@b = 2

		twice_b: ->
			@b * 2

	class CollidesWithTwiceA
		twice_a: ->
			8

	class AB
		@does A
		@does B

		constructor: ->
			@init()

		twice: ->
			@twice_a() + @twice_b()

		toString: ->
			'<an AB>'


	describe 'traits', ->
		it "can't collide 'does' (without precede)", ->
			expect(-> CollidesWithTwiceA.does A).toThrow()

		it "'does' only works with constructor.does(trait)", ->
			expect(-> 1.does A).toThrow()
			expect(-> AB.does 1).toThrow()

		it "class 'does' trait", ->
			ab = new AB
			expect(ab.twice_a()).toEqual 2
			expect(ab.twice_b()).toEqual 4
			expect(ab.twice()).toEqual 6
