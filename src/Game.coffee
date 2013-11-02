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
			@_state = state

		###
		Method: play
		###
		play: ->
			@gl.initLoaders =>
				@_step()

		###
		Method: step
		###
		_step: ->
			try
				requestAnimationFrame =>
					@_step()
				@_state.step()
				@_state.draw @gl

			catch error
				console.trace()
				throw error
