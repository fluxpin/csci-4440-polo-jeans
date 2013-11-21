define (require) ->
	Graphics = require 'Render/Graphics'
	ResourceCache = require 'ResourceCache'
	ShaderLoader = require 'Loader/ShaderLoader'
	TextureLoader = require 'Loader/TextureLoader'

	requestAnimationFrame =
		window.requestAnimationFrame ? window.mozRequestAnimationFrame

	check requestAnimationFrame?, ->
		"Can't get 'requestAnimationFrame'"

	###
	Class: Game
	###
	class Game
		###
		Method: constructor
		Paremeters:
			div - A <div> element of size width x height.
			width - width of the game area.
			height -  height of the game area.
		###
		constructor: (div, width, height) ->
			Graphics.instance div, width, height
			@_ready = @_initResources()
			@wasError = no

		###
		Method: play
		###
		play: (state) ->
			@_ready.then =>
				@changeState new state
				@_step()

		#
		_initResources: ->
			cache = ResourceCache.instance()
			shaders = new ShaderLoader '/res/shaders'
			textures = new TextureLoader '/res/textures'
			$.when(shaders.load(), textures.load()).then (shads, texts) =>
				cache.storeAll shads
				cache.storeAll texts
				@_initDefaultProgram()

		#
		_initDefaultProgram: ->
			cache = ResourceCache.instance()
			graphics = Graphics.instance()
			gl = graphics.context

			vert = cache.get 'default.vert'
			frag = cache.get 'default.frag'
			program = graphics.linkProgram vert, frag
			program.name = 'default.shad'
			gl.useProgram program

			program.pMatrix = gl.getUniformLocation program, 'p_matrix'
			program.mvMatrix = gl.getUniformLocation program, 'mv_matrix'
			program.layer = gl.getUniformLocation program, 'layer'

			program.vertex = gl.getAttribLocation program, 'vertex'
			gl.enableVertexAttribArray program.vertex
			program.aTexCoord = gl.getAttribLocation program, 'a_tex_coord'
			gl.enableVertexAttribArray program.aTexCoord

			program.tex = gl.getUniformLocation program, 'tex'

			cache.store program

		#
		_step: ->
			try
				unless @wasError
					requestAnimationFrame =>
						@_step()
					@_state.step()
					@_state.draw()

			catch error
				@wasError = yes
				console.log error.stack
				throw error

		###
		Method: changeState
		###
		changeState: (state) ->
			@_state = state
			@_state.game = @
