define (require) ->
	{ PlayState } = require 'GameState'
	GameObject = require 'GameObject'
	{ MoveSprite } = GameObject
	Player = require './Player'
	Vec2 = require 'Vec2'
	Rect = require 'Rect'

	class TimerEvent
		constructor: (@time, @event) ->
			type @time, Number
			type @event, Function
			null



	class Timer extends GameObject
		@unique()

		constructor: ->
			@events = []
			@time = 0

		add: (time, event) ->
			@events.push new TimerEvent @time + time, event

			@events.sort (a, b) ->
				a.time - b.time

		repeat: (time, event) ->
			check time > 0

			x = =>
				event()
				@add time, x

			@add time, x

		step: ->
			while @events.length > 0 and @events[0].time == @time
				@events[0].event()
				@events.shift()

			@time += 1



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

