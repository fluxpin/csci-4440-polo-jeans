define (require) ->
	###
	Class: Sprite
	An object with an @animation that appears at its @shape.
	TODO TEST
	###
	class Sprite extends require './GameObject'
		@does (require './HasAnimation'), require './HasShape'

		constructor: ->
			super()

		###
		Method: draw
		TODO
		Draws the animation in the right place.
		###
		draw: ->
			todo
			#MOVE CAMERA HERE
			#@animation.draw()
			#POP CAMERA





