###
Trait: CallsBack
Provides methods for classes that have TraitMergingData callbacks.
###
class window.CallsBack
	_callBackArray: (array, a, b, c, d, e) ->
		type array, Array
		array.forEach (callBack) =>
			type callBack, Function
			callBack.call @, a, b, c, d, e

	###
	Method: callBack
	Calls every func in the TraitMergingList of the given name.
	If the list does not exist, does nothing.
	The callbacks are called with this as the this parameter.

	Parameters:
		listName - The callback list.
			Must be a TraitMergingList or undefined.
		abcde - Arguments passed to every callback.
	###
	callBack: (list, a, b, c, d, e) ->
		if list?
			type list, TraitMergingList
			@_callBackArray list.data, a, b, c, d, e

	###
	Method: callBackMap
	Calls every func in the TraitMergingMultiMap entry of the given name.
	If either the map or the entry does not exist, does nothing.
	The callbacks are called with this as the this parameter.

	Parameters:
		mapName - The callback map.
			Must be a TraitMergingMultiMap or undefined.
		key - Name of the map entry.
		abcde - Arguments passed to every callback.
	###
	callBackMap: (map, key, a, b, c, d, e) ->
		if map?[key]?
			type map, TraitMergingMultiMap
			@_callBackArray map[key], a, b, c, d, e



describe 'CallsBack', ->
	it 'lists', ->
		class A
			@does CallsBack

			@on 'a', ->
				@aWorked = yes
			@on 'a', (x) ->
				@aWorked2 = x

			test: ->
				@callBack @onA, 42
				expect(@aWorked).toEqual yes
				expect(@aWorked2).toEqual 42

		(new A).test()

	it 'maps', ->
		class A
			@does CallsBack
			@mMapAdd 'onStuff', 'a', ->
				@aWorked = yes

			test: ->
				@callBackMap @onStuff, 'a'
				expect(@aWorked).toEqual yes

		(new A).test()

	it 'works empty', ->
		class A
			@does CallsBack

			test: ->
				@callBack @nope
				@callBackMap @nope, 'key'

		(new A).test()
