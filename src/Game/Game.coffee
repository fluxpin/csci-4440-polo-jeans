define (require) ->
	Graphics = require '../Graphics'
	GameState = require '../GameState/GameState'
	###
	Class: Game
	Initializes WebGL and manages all other necessary objects.
	###
	class Game
		#shaders: {}
		#textures: {}
		#angle: 0
		#sync: 0

		###
		Method: constructor
		Creates a canvas in the provided div and initializes the global WebGL
		context. Refer to the context with *gl* (eg *gl.clearColor*).

		Parameters:
		div - The div where the game should be rendered.
		x - The horizontal resolution of the game.
		y - The vertical resolution of the game.
		###
		constructor: (div, width, height, @state) ->
			type @state, GameState
			@graphics = new Graphics div, width, height, => @start()

		play: ->
			@graphics.initLoaders =>
				console.log "All loaded!"
				@tick()
			#Somehow tick gets called?

		tick: =>
			try
				@step()
				@draw()
				mozRequestAnimationFrame @tick
			catch error
				console.trace()
				throw error

		step: ->
			@state.step()

		draw: ->
			@graphics.initFrame()
			@state.draw @graphics
