define (require) ->
	{ MoveSprite } = require 'GameObject'
	Vec2 = require 'Vec2'
	Animation = require 'Render/Animation'

	class ImageObject extends MoveSprite
		constructor: (@imageName, @sizeX, @sizeY) ->
			super()
			@animation.setLayer -1

		animationName: ->
			@imageName

		animationSize: ->
			[@sizeX, @sizeY]

		#step: ->
		#	@animation.step()

		#draw: ->
		#	@animation.draw()
