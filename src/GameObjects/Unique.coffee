define (require) ->
	class Unique
		@onDoes (user) ->
			user.listAdd 'uniqueTypes', user
