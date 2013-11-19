define (require) ->
	###
	Class: Singleton
	Define a singleton class. Inherit from this class to provide a concrete
	implementation.
	###
	class Singleton
		###
		Method: instance
		Construct or retrieve the singleton instance.
		###
		@instance: (args...) ->
			@_instance ?= new @ args...
