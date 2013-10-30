define (require) ->
	###
	Class: TextureLoader
	Loads and configures textures.
	###
	class TextureLoader extends require './Loader'
		###
		Method: constructor
		Asynchronously loads, configures, and returns textures via the provided
		callback.

		Parameters:
		callback - A function (*callback: (texture, entry, done) ->*) that will
		accept textures.
		###
		constructor: (@gl, callback) ->
			super '/res/textures', callback

		###
		Method: load
		Loads the texture specified by the provided path and entry.

		Parameters:
		entry - An index entry specifying a texture.
		###
		load: (entry) =>
			textureReq = new Image()
			textureReq.onload = =>
				@process textureReq, entry
			textureReq.src = "#{@path}/#{entry.name}"

		###
		Method: process
		Configures the provided texture.

		Parameters:
		image - A texture image.
		entry - An index entry specifying the texture.
		###
		process: (image, entry) ->
			texture = @gl.createTexture()
			@gl.bindTexture @gl.TEXTURE_2D, texture
			@gl.pixelStorei @gl.UNPACK_FLIP_Y_WEBGL, true
			@gl.texImage2D @gl.TEXTURE_2D, 0, @gl.RGBA, @gl.RGBA, @gl.UNSIGNED_BYTE,
						image
			@gl.texParameteri @gl.TEXTURE_2D, @gl.TEXTURE_MAG_FILTER, @gl.NEAREST
			@gl.texParameteri @gl.TEXTURE_2D, @gl.TEXTURE_MIN_FILTER, @gl.NEAREST
			@gl.bindTexture @gl.TEXTURE_2D, null
			@sync = @sync - 1
			@callback texture, entry, if @sync then false else true
