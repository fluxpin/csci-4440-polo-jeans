define (require) ->
	###
	Trait: Inits
	Provides @onInit
	###
	class Inits
		@onDoes (user) ->
			user.extend
				###
				Class Method: onInit
				Adds a GameObject initializer.
				###
				onInit: (initializer) ->
					@on 'initializers', initializer
