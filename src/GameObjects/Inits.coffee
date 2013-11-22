define (require) ->
	{ extend } = require 'jquery'
	require 'meta'
	CallsBack = require './CallsBack'

	###
	Trait: Inits
	Provides @onInit
	###
	class Inits
		@does CallsBack

		###
		Method: initialize
		Call every @onInit handler.
		###
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
