define (require) ->
	$ = require 'jquery'

	###
	Class: Loader
	###
	class Loader
		###
		Method: constructor
		###
		constructor: (@_path) ->

		###
		Method: load
		###
		load: ->
			index = $.getJSON "#{@_path}/index.json"
			index.then (index) =>
				$.when.apply($, @_load e for e in index).then (args...) =>
					@_process.apply @, resource for resource in args

		# Define how to load a type of resource. Return a deferred tuple of
		# entry and resource.
		_load: (entry) ->

		# Define how to transform a resource into processed form. Return the
		# processed resource.
		_process: (entry, resource) ->
