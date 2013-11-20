define (require) ->
	M = require 'matrix'
	Animation = require 'Animation'
	GameObject = require 'GameObject'
	PlayState = require './PlayState'
	Graphics = require 'Graphics'

	class Dummy extends GameObject
		constructor: ->
			@animation = new Animation 'ball.png', 200, 200
			@animation.do 'move'
			@angle = 0.0
			@timer = 0

		step: ->
			@angle += 0.05 # 0.05 rads ~ 3 degs ~ 180 degs/s
			if @angle >= 360.0
				@angle -= 360.0
			@timer += 1
			@animation.step()

		draw: ->
			graphics = Graphics.instance()
			M.mat4.rotateZ graphics.mvMatrix, graphics.mvMatrix, @angle
			@animation.draw()

		dead: ->
			if @timer >= 200
				true
			else false



	class Pauser extends GameObject
		constructor: ->
			@timer = 0
			@unpause = 0
		###
		step: ->
			@timer += 1
			if @timer > 200
				@timer = 0
				@gameState.changeState()
		###
		draw: (arg) ->
			@unpause += 1
			if @unpause > 50
				@unpause = 0
				@gameState.changeState()



	class TestState extends PlayState
		constructor: ->
			super
			@addObject new Dummy
			@addObject new Pauser
