###
Class: Object
###


equiv = (a, b) ->
	a == b or \
		(a instanceof Function and b instanceof Function and \
			a.toString() == b.toString())

objectExtend =
	###
	Method: extend
	One object copies all the properties of another.
	Throws an MemberCollisionError if it already has such a property.
	###
	extend: (extension) ->
		(Object.keys extension).forEach (key) =>
			@addMember key, extension[key]
		@

	###
	Method: className
	Gets the name of the object's class.
	###
	className: ->
		@constructor.name

	###
	Method: maybeCreate
	If a member does not already exist, gives it the default value.
	Parameters:
		name - name of my member to possibly create
		value - value to set it to if it is created. Defaults to {}.
	###
	maybeCreate: (name, value) ->
		unless @[name]?
			@[name] = value ? {}

	###
	Method: addMember
	If a member does not already exist, adds it.
	If the member exists and is identical, ignore it.
	Otherwise throws a MemberCollisionError.
	###
	addMember: (name, value) ->
		value = value ? yes
		if @[name]?
			unless equiv @[name], value
				alert @[name]
				alert value
				throw new MemberCollisionError @, name, value
		else
			@[name] = value

	#
	#Method: createAndAddMember
	#DOC ME
	#
	#createAndAddMember: (name, key, value) ->
	#	@maybeCreate name
	#	@[name].addMember key, value

(Object.keys objectExtend).forEach (name) ->
	Object.prototype[name] = objectExtend[name]



###
Class: AddMemberError
Thrown by <maybeCreate>.
###
class window.MemberCollisionError extends Error
	constructor: (@object, @name, @value) ->
		@message =
			"#{@object}.#{@name} is #{@object[@name]}, cannot extend to #{@value}"



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

