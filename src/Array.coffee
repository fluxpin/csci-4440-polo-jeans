define (require) ->
	{ extend } = require 'jquery'

	###
	Class: Array
	###
	extend Array.prototype,
		###
		Method: remove
		Takes obj out of me.
		Must contain obj.
		###
		remove: (obj) ->
			pos = @indexOf obj
			check pos >= 0, =>
				"Tried to remove #{obj} from #{@}, but did not have it."
			@splice pos, 1
