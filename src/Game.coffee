define (require) ->
	Graphics = require 'Graphics'

	requestAnimationFrame =
		window.requestAnimationFrame ? window.mozRequestAnimationFrame

	check requestAnimationFrame?, ->
		fail "Can't get 'requestAnimationFrame'"

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
			state - GameState this Game will start with.
		###
		constructor: (div, width, height, state) ->
			@gl = new Graphics div, width, height
			@changeState state
			@_ready = @gl.initLoaders()

		###
		Method: play
		###
		play: ->
			@_ready.then =>
				@_step()

		#
		_step: ->
			try
				requestAnimationFrame =>
					@_step()
				@_state.step()
				@_state.draw @gl

			catch error
				console.trace()
				throw error

		###
		Method: changeState
		###
		changeState: (state) ->
			@_state = state
			@_state.game = @
