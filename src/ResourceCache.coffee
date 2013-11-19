define (require) ->
	Singleton = require 'Singleton'

	###
	Class: ResourceCache
	Cache immutable resources. Identify resources only by name.
	###
	class ResourceCache extends Singleton
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

		###
		Method: storeAll
		###
		storeAll: (resources) ->
			@store r for r in resources

		# Private
		constructor: ->
			@_cache = {}
