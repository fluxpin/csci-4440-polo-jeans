define (require) ->
	{ MoveSprite } = require 'GameObject'
	Vec2 = require 'Vec2'
	Animation = require 'Render/Animation'

	###
	Class: ImageObject
	Displays an image at the origin.
	###
	class ImageObject extends MoveSprite
		###
		Constructor: ImageObject

		Parameters:
			imageName - Name of image (include extension)
			sizeX - width of image
			sizeY - height of image
		###
		constructor: (@imageName, @sizeX, @sizeY) ->
			super()
			@setLayer 3

		animationName: ->
			@imageName

		animationSize: ->
			[@sizeX, @sizeY]
