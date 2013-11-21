define (require) ->
	{ extend } = require 'jquery'

	extend Array.prototype,
		remove: (obj) ->
			pos = @indexOf obj
			check pos >= 0
			@splice pos, 1
