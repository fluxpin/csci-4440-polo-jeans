define (require) ->
	ResourceCache = require 'ResourceCache'

	###
	Class: Animation
	###
	class Animation
		###
		Method: constructor
		###
		constructor: (name, width, height, @_gl) ->
			gl = @_gl.f

			# Get texture
			cache = ResourceCache.getInstance()
			@_texture = cache.get name

			# Create sprite geometry
			@_sprite = gl.createBuffer()
			gl.bindBuffer gl.ARRAY_BUFFER, @_sprite
			dx = width / 2.0
			dy = height / 2.0
			gl.bufferData gl.ARRAY_BUFFER, new Float32Array([
				 dx,  dy,
				-dx,  dy,
				 dx, -dy
				-dx, -dy
			]), gl.STATIC_DRAW

			@_frames = @_texture.frames # Animation frames
			@_delay = 0 # Frame delay for current animation
			@_indices = [0] # Frame indices for current animation
			@_timer = 0 # Frame delay timer
			@_index = 0 # Index of current frame index

			# Create texture frame
			@_frame = gl.createBuffer()
			gl.bindBuffer gl.ARRAY_BUFFER, @_frame
			gl.bufferData gl.ARRAY_BUFFER, @_frames[@_indices[@_index]],
			              gl.DYNAMIC_DRAW

		###
		Method: set
		###
		set: (animation) ->
			gl = @_gl.f

			@_delay = @_texture[animation].delay
			@_indices = @_texture[animation].frames
			@_timer = 0
			@_index = 0
			gl.bindBuffer gl.ARRAY_BUFFER, @_frame
			gl.bufferSubData gl.ARRAY_BUFFER, 0, @_frames[@_indices[@_index]]

		###
		Method: step
		###
		step: ->
			gl = @_gl.f

			unless @_indices.length == 1
				@_timer += 1
				if @_timer >= @_delay
					@_timer = 0
					@_index = (@_index + 1) % @_indices.length
					gl.bindBuffer gl.ARRAY_BUFFER, @_frame
					gl.bufferSubData gl.ARRAY_BUFFER, 0, @_frames[@_indices[@_index]]

		###
		Method: draw
		###
		draw: ->
			gl = @_gl.f

			# Refresh transform matrices
			@_gl.loadMatrices @_gl.prog
			# Bind geometry to the context
			gl.bindBuffer gl.ARRAY_BUFFER, @_sprite
			gl.vertexAttribPointer @_gl.prog.vertex, 2, gl.FLOAT, false, 0, 0
			gl.bindBuffer gl.ARRAY_BUFFER, @_frame
			gl.vertexAttribPointer @_gl.prog.aTexCoord, 2, gl.FLOAT, false, 0, 0
			# Bind texture to the context
			gl.activeTexture gl.TEXTURE0
			gl.bindTexture gl.TEXTURE_2D, @_texture
			gl.uniform1i @_gl.prog.tex, 0
			# Draw the sprite
			gl.drawArrays gl.TRIANGLE_STRIP, 0, 4