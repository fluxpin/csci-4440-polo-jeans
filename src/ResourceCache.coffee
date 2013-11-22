define (require) ->
	Singleton = require 'Singleton'

	###
	Class: ResourceCache
	Cache immutable resources. Identify resources only by name.
	###
	class ResourceCache extends Singleton
		###
		Method: get
		Return a resource. Fail if the resource does not exist.
		Parameters:
		name - The name of a resource.
		###
		get: (name) ->
			if @_cache[name]?
				@_cache[name]
			else
				fail "Resource unavailable: #{name}"

		###
		Method: store
		Store a resource. Fail if the resource already exists.
		Parameters:
		resource - A named resource (has a name field).
		###
		store: (resource) ->
			unless @_cache[resource.name]?
				@_cache[resource.name] = resource
			else
				fail "Immutable resource: #{resource.name}"

		###
		Method: storeAll
		Store a list of resources. Fail if any of the resources already exist.
		Parameters:
		resources - A list of named resources (have name fields).
		###
		storeAll: (resources) ->
			@store r for r in resources

		# Private
		constructor: ->
			@_cache = {}
