define (require) ->
	extend = (require 'jquery').extend
	require 'meta'
	###
	Trait: Inits
	Provides @onInit
	###
	class Inits
		@does require './CallsBack'

		initialize: ->
			@callBack @_on_init

		@onDoes (user) ->
			extend user,
				###
				Class Method: onInit
				Adds a GameObject initializer.
				###
				onInit: (initializer) ->
					@on 'init', initializer
