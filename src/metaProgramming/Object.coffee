define ->
	equiv = (a, b) ->
		a == b or \
			(a instanceof Function and b instanceof Function and \
				a.toString() == b.toString())

	###
	Method: addMember
	If a member does not already exist, adds it.
	If the member exists and is identical, ignore it.
	Otherwise throws a MemberCollisionError.
	###
	addMember = (obj, name, value) ->
		value = value ? yes
		if obj[name]?
			unless equiv obj[name], value
				alert obj[name]
				alert value
				throw new MemberCollisionError obj, name, value
		else
			obj[name] = value

	###
	Method: className
	Gets the name of the object's class.
	###
	className = (obj) ->
		obj.constructor.name

	###
	Method: maybeCreate
	If a member does not already exist, gives it the default value.
	Parameters:
		name - name of my member to possibly create
		value - value to set it to if it is created. Defaults to {}.
	###
	maybeCreate = (name, value) ->
		unless @[name]?
			@[name] = value ? {}

	#
	#Method: createAndAddMember
	#DOC ME
	#
	#createAndAddMember: (name, key, value) ->
	#	@maybeCreate name
	#	@[name].addMember key, value


	###
	Class: AddMemberError
	Thrown by <maybeCreate>.
	###
	class MemberCollisionError extends Error
		constructor: (@object, @name, @value) ->
			@message =
				"#{@object}.#{@name} is #{@object[@name]}, cannot extend to #{@value}"

	###
	describe 'objects', ->
		it 'can extend', ->
			a =
				a: 1
			b =
				b: 2
			ab =
				a: 1
				b: 2
			bc =
				b: 2
				c: 3
			abc =
				a: 1
				b: 2
				c: 3
			b4 =
				b: 4

			a.extend b
			expect(a).toEqual ab
			a.extend bc
			expect(a).toEqual abc

			expect(-> a.extend b4).toThrow
	###

	maybeCreate: maybeCreate

