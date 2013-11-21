define (require) ->
	GameObject = require 'GameObject'
	{ Sprite, HasSounds } = GameObject
	Vec2 = require 'Vec2'

	winScore = 10

	class Counter extends Sprite
		@does HasSounds

		constructor: (x, @name) ->
			super()
			@animation.setLayer 5
			@count = 0
			y = @gameState().height()/2 - @animationSize()[1]/2
			@warp new Vec2 x, y

			@addSound 'score', "res/sounds/score-#{@name}.ogg"

		animationSize: -> [64, 64]

		increase: ->
			@count += 1
			@playSound 'score'
			if @count >= winScore
				yes
			else
				@animation.do @count.toString()
				no

	class ScoreKeeper extends GameObject
		@unique()

		constructor: ->
			super()

			@left = @emit new Counter -100, 'wasd'
			@right = @emit new Counter 100, 'arrows'

		scoreLeft: ->
			@_score @left

		scoreRight: ->
			@_score @right

		_score: (counter) ->
			type counter, Counter
			if counter.increase()
				@gameState().win counter.name
