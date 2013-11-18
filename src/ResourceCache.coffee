define (require) ->
	###
	Class: ResourceCache
	Provide a singleton cache for immutable resources. Get and store
	resources by name.
	###
	class ResourceCache
		###
		Method: getInstance
		Construct or retrieve the ResourceCache instance.
		###
		@getInstance: ->
			@_instance ?= new @ arguments...

		###
		Method: get
		###
		get: (name) ->
			if @_cache[name]?
				@_cache[name]
			else
				fail "Resource unavailable: #{name}"

		###
		Method: store
		###
		store: (resource) ->
			unless @_cache[resource.name]?
				@_cache[resource.name] = resource
			else
				fail "Immutable resource: #{resource.name}"

		# Private
		constructor: ->
			@_cache = {}
