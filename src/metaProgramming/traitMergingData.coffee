###
Abstract Class: TraitMergingData
###
class window.TraitMergingData
	###
	Method: clone
	Produces an identical TraitMergingData.
	###
	clone: abstract

	###
	Method: merge
	Produces a *new* TraitMergingData containing
	the data of this and another of the same type.
	###
	merge: abstract



###
Class: TraitMergingList
Maintains a list of anything.
Ignores repeated values.
###
class window.TraitMergingList extends TraitMergingData
	constructor: ->
		@data = []

	clone: ->
		@merge new TraitMergingList

	merge: (merged) ->
		a = new TraitMergingList
		@data.forEach (x) -> a.add x
		merged.data.forEach (x) -> a.add x
		a

	###
	Method: add
	Adds a single value to the list, unless it was already in it.
	###
	add: (value) ->
		unless value in @data
			@data.push value



###
Abstract Class: TraitMergingAbstractMap
DESCRIBE ME
###
class window.TraitMergingAbstractMap extends TraitMergingData
	clone: ->
		(new @constructor).extend @

	###
	Method: add
	If the name is new, simply add (name: value) to the map.
	If there is a name conflict,
		call @mergeSingle to combine new and old values.
	###
	add: (name, value) ->
		@[name] =
			if @[name]?
				@mergeSingle @[name], value
			else
				value


	merge: (merged) ->
		a = @clone()

		(Object.keys merged).forEach (name) ->
			a.add name, merged[name]

		a

	###
	When the same name is used twice,
	this combines the values.
	###
	mergeSingle: abstract

	toString: ->
		inspect @



###
Class: TraitMergingMap
Keeps (name: value) pairs.
Fails when values collide.
###
class window.TraitMergingMap extends TraitMergingAbstractMap
	mergeSingle: (a, b) ->
		fail "TraitMergingMap conflict of #{a} and #{b}"


###
Class: TraitMergingMultiMap
Keeps (name: [values]) pairs.
Joins lists of values when they collide.
###
class window.TraitMergingMultiMap extends TraitMergingAbstractMap
	mergeSingle: (a, b) ->
		a.concat b



###
Class: TraitMergingSet
Keeps a set of names.
Keeps only Strings; for objects that use TraitMergingList.
###
class window.TraitMergingSet extends TraitMergingAbstractMap
	mergeSingle: (a, b) ->
		yes

	add: (name) ->
		super(name, yes)

	###
	Method: contains
	Whether the given name is in the set.
	###
	contains: (name) ->
		@[name]?

	###
	Method: toArray
	###
	toArray: ->
		Object.keys @






newOrClone = (obj, name, ctr) ->
	obj[name] =
		if obj[name]?
			obj[name].clone()
		else
			new ctr

capitalizeFirstLetter = (string) ->
	(string.charAt 0).toUpperCase() + string.slice 1

toOnX = (name) ->
	"on#{capitalizeFirstLetter name}"

###
Class: Function
###
Function.prototype.extend
	###
	Class Method: listAdd
	Add a new <TraitMergingList> member to my prototype.
	###
	listAdd: (name, value) ->
		newOrClone @prototype, name, TraitMergingList
		@prototype[name].add value

	###
	Class Method: setAdd
	Add a new <TraitMergingSet> member to my prototype.
	###
	setAdd: (name, value) ->
		newOrClone @prototype, name, TraitMergingSet
		@prototype[name].add value

	###
	Class Method: mapAdd
	Add a new <TraitMergingMap> (name: value) pair to my prototype.
	Fails if the key is already in use.
	###
	mapAdd: (name, key, value) ->
		newOrClone @prototype, name, TraitMergingMap
		@prototype[name].add key, value

	###
	Class Method: mMapAdd
	Add a new <TraitMergingMultiMap> (name: value) pair to my prototype.
	###
	mMapAdd: (mapName, key, value) ->
		newOrClone @prototype, mapName, TraitMergingMultiMap
		@prototype[mapName].add key, [value]

	###
	Class Method: on
	Registers a function with a TraitMergingList of callbacks.
	Parameters:
		name - Event name
		fun - New callback
	eg
	> @on 'hotStove', ->
	>	@ouchHot()
	registers the function with the event 'onHotStove'
	###
	on: (name, fun) ->
		type name, String
		type fun, Function
		@listAdd (toOnX name), fun

	###
	Class Method: onKey
	Registers a function with a TraitMergingMap of keys to callbacks.
	eg
	> @onKey 'buttonDown', 'A', ->
	>	@jump()
	registers the function with the map 'onButtonDown' at entry 'A'
	###
	onKey: (mapName, key, fun) ->
		type mapName, String
		type key, String
		type fun, Function
		@mMapAdd (toOnX mapName), key, fun

	###
	Class Method: onDoes
	Registers a callback for when a class @does a trait.
	###
	onDoes: (fun) ->
		@on 'does', fun



describe "TraitMergingData", ->
	it 'TODO: more testing here', ->

	it 'TraitMergingSet', ->
		x = new TraitMergingSet
		x.add 'one'
		y = new TraitMergingSet
		y.add 'two'
		z = x.merge y
		expect(z.contains 'one').toEqual yes
		expect(z.contains 'two').toEqual yes
