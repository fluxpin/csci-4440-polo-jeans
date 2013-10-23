define (require) ->
	Function.prototype.extend
		###
		Class Method: unique
		Marks this type as unique.
		There can be only one object per GameState that isA this type.
		###
		unique: ->
			@setAdd 'uniqueTypes', @name

	###
	Class: UniqueServer
	Keeps track of Unique objects.
	###
	class UniqueServer
		constructor: ->
			@uniques = {}

		###
		Prop: uniques
		Map of type names to unique objects.
		###


		###
		Method: add
		Call this every time the GameState gets a new object.
		Logs every unique type of the object's in the server.
		Throws a UniqueConflictError if one already exists.
		###
		add: (object) ->
			object.uniqueTypes?.toArray().forEach (uniqueType) =>
				old =
					@uniques[uniqueType]
				check not old?, ->
					new UniqueConflictError old, object, uniqueType

				@uniques[uniqueType] = object

		###
		Method: remove
		Call this every time the GameState loses an object.
		Removes every unique type of the object's from the server.
		GameState should first check that the object was ever added.
		###
		remove: (object) ->
			object.uniqueTypes?.toArray().forEach (uniqueType) =>
				old =
					@uniques[uniqueType]
				check @uniques[uniqueType]?, ->
					"Losing object #{object} that was not in @uniques?"

				delete @uniques[uniqueType]

		###
		Method: the
		Returns the unique object of the type,
			or undefined if there is none.
		eg
		> the Player
		###
		the: (ctr) ->
			type ctr, Function
			@uniques[ctr.name]



	###
	Class: UniqueConflictError
	Thrown when two Uniques of the same type are added to the same UniqueServer.
	###
	class UniqueConflictError
		constructor: (@first, @newOne, @uniqueType) ->
			@message =
				"#{@first} and #{@newOne} are of unique type #{@uniqueType.name}"


	describe 'UniqueServer', ->
		it 'works simple', ->
			class A
				@unique()
			us =
				new UniqueServer
			a =
				new A

			us.add 3
			expect(us.uniques).toEqual {}
			us.add a
			expect(us.the A).toEqual a
			expect(-> us.add new A).toThrow()
			us.remove a
			expect(us.the A).toEqual undefined

		it 'works with multiple unique types', ->
			class House
				@unique()
			class RocketShip
				@unique()
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
			expect(us.the House).toEqual undefined
			expect(us.the RocketShip).toEqual undefined

