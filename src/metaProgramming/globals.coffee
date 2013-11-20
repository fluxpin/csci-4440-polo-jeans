define (require) ->
	extend = (require 'jquery').extend

	Globals =
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
				console.trace()
				err =
					if error_message_maker?
						error_message_maker()
					else
						"Check failed"
				if typeof err is 'string'
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
		Func: inspect
		Produces a string showing the members of an object.
		###
		inspect: (object) ->
			if typeof object is 'object' and object != null
				if object instanceof Array
					'[' + (object.join ', ') + ']'
				else
					inner = (Object.keys object).map (key) ->
						"#{key}: #{inspect(object[key])}"
					object.constructor.name + '(' + (inner.join ', ') + ')'
			else
				String object

		###
		Func: todo
		Throws a NotImplementedError.
		###
		todo: (text) ->
			throw new NotImplementedError text

		type: (obj, type) ->
			check obj?, ->
				"Object is undefined!"
			check (obj.isA type), ->
				"#{obj} is not of expected type #{type.name}"

	extend window, Globals

	###
	Class: NotImplementedError
	Thrown by <todo>.
	###
	class window.NotImplementedError extends Error
		constructor: (@text) ->
			@message = "Function not implemented; description: '#{@text}'"


