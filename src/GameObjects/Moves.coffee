define (require) ->
	Vec2 = require 'Vec2'
	GameObject = require './GameObject'
	Inits = require './Inits'
	HasPos = require './HasPos'

	###
	Trait: Moves
	Provides funcs for any Body with a @vel.
	Requires a function @move.
	###
	class Moves extends GameObject
		@does Inits, HasPos

		###
		Event: init
		Sets vel to 0.
		###
		@onInit ->
			@_vel = Vec2.zero()

		###
		Method: vel
		Velocity.
		###
		vel: ->
			@_vel

		###
		Event: step
		Move by vel.
		###
		@onStep ->
			@move @vel()

		###
		Method: accelerate
		Add the given amount to my velocity.
		###
		accelerate: (accelerateBy) ->
			type accelerateBy, Vec2
			@vel().add accelerateBy

		###
		Method: bounceLeft
		Reflect rightward motion left.
		###
		bounceLeft: ->
			@vel().setX @vel().x().toNegative()

		###
		Method: bounceRight
		Reflect leftward motion right.
		###
		bounceRight: ->
			@vel().setX @vel().x().toPositive()

		###
		Method: bounceDown
		Reflect upward motion down.
		###
		bounceDown: ->
			@vel().setY @vel().y().toNegative()

		###
		Method: bounceUp
		Reflect downard motion up.
		###
		bounceUp: ->
			@vel().setY @vel().y().toPositive()

		###
		Method: stopMoving
		Zeros vel.
		###
		stopMoving: ->
			@vel().set Vec2.zero()



	describe 'Moves', ->
		it 'moves', ->
			class X extends GameObject
				@does Moves

				constructor: ->
					@initialize()

			x = new X()
			right = Vec2.right()
			expect(x.pos()).toEqual Vec2.zero()
			x.accelerate right
			expect(x.vel()).toEqual right
			x.step()
			expect(x.pos()).toEqual right
			x.step()
			expect(x.vel()).toEqual right
			expect(x.pos()).toEqual Vec2.right 2

	Moves
