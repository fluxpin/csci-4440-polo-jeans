define (require) ->
	{ PlayState } = require 'GameState'
	GameObject = require 'GameObject'
	{ MoveSprite, Timer } = GameObject
	Player = require './Player'
	Vec2 = require 'Vec2'
	Rect = require 'Rect'



	class FramerateTracker extends GameObject
		constructor: ->
			getMillis = ->
				(new Date).getTime()

			lastTime =
				getMillis()
			framesPerTest =
				100

			(@the Timer).repeat framesPerTest, =>
				now = getMillis()
				secsTaken = (now - lastTime) / 1000
				lastTime = now
				rate = framesPerTest / secsTaken

				console.log "FPS: #{rate} with #{@gameState().gameObjects.length} objects"



	class Ball extends MoveSprite
		constructor: ->
			super()

			ang = Math.random() * Number.TwoPi
			s = 3
			@accelerate new Vec2 s * ang.cos(), s * ang.sin()

		animationSize: ->
			[64, 64]

		step: ->
			super()

			r = Rect.centered Vec2.zero(), new Vec2 512, 512

			p = @pos()
			if p.x() < -256
				@bounceRight()
			if p.x() > 256
				@bounceLeft()
			if p.y() < -256
				@bounceUp()
			if p.y() > 256
				@bounceDown()



	class MakesBalls extends GameObject
		constructor: ->
			(@the Timer).repeat 10, =>
				@emit new Ball


	class Test4 extends PlayState
		constructor: ->
			super 512, 512

			@addObject new Timer
			@addObject new MakesBalls
			@addObject new FramerateTracker

			@camera.lookAt Vec2.zero()

