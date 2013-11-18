define (require) ->
	$ = require 'jquery'
	Loader = require 'Loader/Loader'

	# Divide a normalized space into equal-sized frames where w is the width
	# of the space in frames and h is the height of the space in frames
	enumFrames = (w, h) ->
		frames = []
		for y in [0..h - 1]
			for x in [0..w - 1]
				xb = x / w
				xe = (x + 1) / w
				yb = 1 - (y + 1) / h
				ye = 1 - y / h
				frames[x + w * y] = new Float32Array [
					xe, ye,
					xb, ye,
					xe, yb,
					xb, yb
				]
		frames

	###
	Class: TextureLoader
	Load WebGL 2D textures.
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

			if entry.type is 'animated'
				texture.frames = enumFrames entry.width, entry.height
				texture[k] = v for k, v of entry.animation
			else if entry.type is 'static'
				texture.frames = enumFrames 1, 1 # Just one 'frame'
			else
				fail 'Invalid or unsupported texture type!'

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
