define (require) ->
	Graphics = require '../Graphics'
	GameState = require '../GameState/GameState'
	TestState = require '../GameState/TestState'

	###
	Class: Game
	Initializes WebGL and manages all other necessary objects.
	###
	class Game
		###
		Method: constructor
		Creates a canvas in the provided div and initializes the global WebGL
		context. Refer to the context with *gl* (eg *gl.clearColor*).

		Parameters:
		div - The div where the game should be rendered.
		x - The horizontal resolution of the game.
		y - The vertical resolution of the game.
		###
		constructor: (div, width, height, state) ->
			@graphics = new Graphics div, width, height, => @start()
			@state = new TestState @graphics

		play: ->
			@graphics.initLoaders =>
				console.log "All loaded!"
				@step()

		step: ->
			try
				@state.step()
				@draw()
				mozRequestAnimationFrame =>
					@step()
			catch error
				console.trace()
				throw error

		draw: ->
			@state.draw @graphics
