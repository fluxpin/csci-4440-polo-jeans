define (require) ->
	extend = (require 'jquery').extend

	###
	Trait: Inits
	Provides @onInit
	###
	class Inits
		@onDoes (user) ->
			extend user,
				###
				Class Method: onInit
				Adds a GameObject initializer.
				###
				onInit: (initializer) ->
					@on 'initializers', initializer
