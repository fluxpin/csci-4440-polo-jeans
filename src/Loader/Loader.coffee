define (require) ->
	$ = require 'jquery'

	###
	Class: Loader
	Asynchronously load an abstract resource from the server. Inherit from
	this class to provide a concrete implementation.
	###
	class Loader
		###
		Method: constructor
		Parameters:
		path - Path to the resource's top-level directory.
		###
		constructor: (@_path) ->

		###
		Method: load
		Request an index of the resource, request all instances of the
		resource, and process each instance. Return a deferred list of
		processed resources.
		###
		load: ->
			$.getJSON("#{@_path}/index.json").then (index) =>
				$.when(@_load e for e in index...).then (resources...) =>
					@_process r... for r in resources

		# Define how to load a type of resource. Return a deferred tuple of
		# entry and resource.
		_load: (entry) ->
			null

		# Define how to transform a resource into processed form. Return the
		# processed resource.
		_process: (entry, resource) ->
			null
