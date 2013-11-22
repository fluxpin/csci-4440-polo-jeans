define (require) ->
	GameObject = require 'GameObject'
	{ Sprite, HasSounds } = GameObject
	Vec2 = require 'Vec2'

	winScore = 10

	###
	Class: Counter
	Tracks a single player's score.
	Tells the state when the player wins.
	###
	class Counter extends Sprite
		@does HasSounds

		###
		Constructor: Counter

		Paremeters:
			x - center x.
			name - 'wasd' or 'arrows'
		###
		constructor: (x, @name) ->
			super()
			@setLayer 5
			@count = 0
			y = @gameState().height()/2 - @animationSize()[1]/2
			@warp new Vec2 x, y

			@addSound 'score', "res/sounds/score-#{@name}.ogg"

		animationSize: -> [64, 64]

		###
		Method: increase
		Give me one more point.
		May tell the GameState I won.
		###
		increase: ->
			@count += 1
			@playSound 'score'
			if @count >= winScore
				@gameState().win @name
			else
				@ani @count.toString()
