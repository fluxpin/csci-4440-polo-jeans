define (require) ->
	$ = require 'jquery'
	Loader = require './Loader'

	###
	Class: TextureLoader
	###
	class TextureLoader extends Loader
		constructor: (@_path, @gl) ->

		#
		_load: (entry) =>
			image = $.Deferred()
			textureReq = new Image
			textureReq.onload = =>
				image.resolve [entry, textureReq]
			textureReq.src = "#{@_path}/#{entry.name}"
			image

		#
		_process: (entry, image) ->
			texture = @gl.createTexture()
			texture.name = entry.name
			@gl.bindTexture @gl.TEXTURE_2D, texture
			@gl.pixelStorei @gl.UNPACK_FLIP_Y_WEBGL, true
			@gl.texImage2D @gl.TEXTURE_2D, 0, @gl.RGBA, @gl.RGBA, @gl.UNSIGNED_BYTE,
						image
			@gl.texParameteri @gl.TEXTURE_2D, @gl.TEXTURE_MAG_FILTER, @gl.NEAREST
			@gl.texParameteri @gl.TEXTURE_2D, @gl.TEXTURE_MIN_FILTER, @gl.NEAREST
			@gl.bindTexture @gl.TEXTURE_2D, null
			texture
