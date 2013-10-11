###
Func: extend
One object copies all the properties of another.
Throws an ExtensionCollisionError if it already has such a property.
###
Object.prototype.extend = (extension) ->
	for key in Object.keys extension
		if @[key]?
			throw new ExtensionCollisionError @, extension, key
		else
			@[key] = extension[key]

###
Class: ExtensionCollisionError
Thrown by <extend>.
###
class window.ExtensionCollisionError extends Error
	constructor: (@object, @extend_with, @property) ->
		@message =
			"#{@object} already has property #{@property}"

Globals =
	###
	Func: inspect
	Produces a string showing the members of an object.
	###
	inspect: (object) ->
		if typeof object == 'object' and object != null
			inner = (Object.keys object).map (key) ->
				"#{key}: #{inspect(object[key])}"
			object.constructor.name + "(" + (inner.join ", ") + ")"
		else
			String object

	###
	Func: check
	If the condition is not met, call the error maker and throw it.
	Parameters:
		condition - Boolean that ought to be the case
		error_message_maker -
			Function that returns an Error or a String.
			If it returns a String, it will be wrapped in an Error.
	###
	check: (condition, error_message_maker) ->
		unless condition
			err = error_message_maker()
			if typeof err == 'string'
				fail err
			else
				throw err

	###
	Func: fail
	Throws an error containing text.
	###
	fail: (text) ->
		throw new Error text

	###
	Const TEST
	Whether to run tests.
	Maybe this could be done better...
	###
	TEST:
		yes

window.extend Globals



if TEST
	describe 'objects', ->
		it 'can extend', ->
			a =
				a: 1
			b =
				b: 2
			ab =
				a: 1
				b: 2

			expect(-> a.extend ab).toThrow()

			a.extend b

			expect(a).toEqual ab


