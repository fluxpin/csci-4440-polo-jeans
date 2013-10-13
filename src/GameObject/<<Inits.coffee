###
Trait: Inits
Provides @onInit
###
class window.Inits
	@onDoes (user) ->
		user.extend
			###
			Class Method: onInit
			Adds a GameObject initializer.
			###
			onInit: (initializer) ->
				@on 'initializers', initializer
