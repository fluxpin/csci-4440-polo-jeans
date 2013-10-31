define (require) ->
	Graphics = require 'Graphics'

	###
	Class: Game
	###
	class Game
		###
		Method: constructor
		###
		constructor: (div, width, height, state) ->
			@gl = new Graphics div, width, height
			@_state = new state @gl

		###
		Method: play
		###
		play: ->
			@gl.initLoaders =>
				console.log 'All loaded!'
				@_step()

		###
		Method: step
		###
		_step: ->
			try
				mozRequestAnimationFrame =>
					@_step()
				@_state.step()
				@_state.draw()
			catch error
				console.trace()
				throw error
