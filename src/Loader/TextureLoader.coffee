define (require) ->
	$ = require 'jquery'
	Loader = require 'Loader/Loader'

	###
	Class: TextureLoader
	Load WebGL 2D textures
	###
	class TextureLoader extends Loader
		###
		Method: constructor
		Parameters:
		path - Path to the resource's top-level directory.
		gl - Graphics object representing the game's WebGL context.
		###
		constructor: (@_path, @_gl) ->

		# Load image
		_load: (entry) ->
			image = $.Deferred()
			req = new Image
			req.onload = ->
				image.resolve [entry, req]
			req.src = "#{@_path}/#{entry.name}"
			image

		# Convert image to texture
		_process: (entry, image) ->
			gl = @_gl.f

			texture = gl.createTexture()
			texture.name = entry.name
			# Bind texture to the context
			gl.bindTexture gl.TEXTURE_2D, texture

			# Texture coordinates increase up the Y axis, whereas image
			# coordinates increase down the Y axis.
			gl.pixelStorei gl.UNPACK_FLIP_Y_WEBGL, true
			# Store image in texture
			gl.texImage2D gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE,
			              image
			# Generate mipmaps for scaling texture
			gl.generateMipmap gl.TEXTURE_2D

			# Unbind texture from the context
			gl.bindTexture gl.TEXTURE_2D, null
			texture
