define (require) ->
	GameObject = require 'GameObject'

	class ImageObject extends GameObject
		constructor: (imageName) ->
			#get my animation

		step: ->
			animation.step()

		draw: ->
			#draw my animation at (0, 0)
