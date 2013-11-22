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
			layer - Layer to display image.
			sizeX - Width of image.
			sizeY - Height of image.
		###
		constructor: (@imageName, layer, @sizeX, @sizeY) ->
			super()
			@setLayer layer

		animationName: ->
			@imageName

		animationSize: ->
			[@sizeX, @sizeY]
