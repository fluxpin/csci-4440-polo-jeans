define (require) ->
	(require 'jquery').extend Function.prototype,
		###
		Class Method: unique
		Marks this type as unique.
		There can be only one object per GameState that isA this type.
		###
		unique: ->
			@listAdd 'uniqueTypes', @


