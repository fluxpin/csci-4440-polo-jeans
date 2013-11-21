define (require) ->
	GameObject = require 'GameObject'
	{ Sprite } = GameObject
	Vec2 = require 'Vec2'

	class Counter extends Sprite
		constructor: (x, @name) ->
			super()
			@animation.setLayer 1
			@count = 0
			y = @gameState().height()/2 - @animationSize()[1]
			@warp new Vec2 x, y

		animationSize: -> [32, 32]

		increase: ->
			@count += 1
			if @count >= 10
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
