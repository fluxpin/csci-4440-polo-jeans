define (require) ->
	require 'meta'
	{ Unique } = require 'GameObject'

	###
	Class: UniqueConflictError
	Thrown when two Uniques of the same type are added to the same UniqueServer.
	###
	class UniqueConflictError extends Error
		constructor: (@first, @newOne, @uniqueType) ->
			@message =
				"#{@first} and #{@newOne} are of both unique type #{@uniqueType.name}"

	class UniqueMissingError extends Error
		constructor: (@type) ->
			@message =
				"There is no unique object of type #{@type}"

	###
	Class: UniqueServer
	Keeps track of Unique objects.
	###
	class UniqueServer
		constructor: ->
			@_uniques = {} # type name -> object of that type

		has: (uniqueType) ->
			type uniqueType, Function
			Object.prototype.hasOwnProperty.call @_uniques, uniqueType.name

		###
		Method: add
		Call this every time the GameState gets a new object.
		Logs every unique type of the object's in the server.
		Throws a UniqueConflictError if one already exists.
		###
		add: (object) ->
			object.uniqueTypes?.toArray().forEach (uniqueType) =>
				type uniqueType, Function
				check not (@has uniqueType), ->
					new UniqueConflictError (@the uniqueType), object, uniqueType

				@_uniques[uniqueType.name] = object

		###
		Method: remove
		Call this every time the GameState loses an object.
		Removes every unique type of the object's from the server.
		GameState should first check that the object was ever added.
		###
		remove: (object) ->
			object.uniqueTypes?.toArray().forEach (uniqueType) =>
				check (@has uniqueType), ->
					"Losing object #{object} that was not in @_uniques?"

				delete @_uniques[uniqueType.name]

		###
		Method: the
		Returns the unique object of the type,
			or undefined if there is none.
		eg
		> the Player
		###
		the: (uniqueType) ->
			type uniqueType, Function
			check (@has uniqueType), ->
				new UniqueMissingError uniqueType

			@_uniques[uniqueType.name]

	describe 'UniqueServer', ->
		it 'works simple', ->
			class A
				@does Unique
			us =
				new UniqueServer
			a =
				new A

			us.add 3
			expect(us._uniques).toEqual {}
			us.add a
			expect(us.the A).toEqual a
			expect(-> us.add new A).toThrow()
			us.remove a
			expect(-> us.the A).toThrow()

		it 'works with multiple unique types', ->
			class House
				@does Unique
			class RocketShip
				@does Unique
			class RocketHouse extends House
				@does RocketShip
			us =
				new UniqueServer
			rh =
				new RocketHouse

			us.add rh
			expect(us.the House).toEqual rh
			expect(us.the RocketShip).toEqual rh
			us.remove rh
			expect(-> us.the House).toThrow()
			expect(-> us.the RocketShip).toThrow()


	UniqueServer
