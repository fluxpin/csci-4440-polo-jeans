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

		@onInit ->
			@_vel = Vec2.zero()

		vel: ->
			@_vel

		###
		?
		At every step, I advance by my velocity.
		###
		@onStep ->
			@move @_vel

		###
		Method: accelerate
		Add the given amount to my velocity.
		###
		accelerate: (accelerateBy) ->
			type accelerateBy, Vec2
			@_vel.add accelerateBy

		#bounceX: ->
		#	@_vel.setX -@_vel.x()

		#bounceY: ->
		#	@_vel.setY -@_vel.y()

		bounceLeft: ->
			@vel().setX @vel().x().toNegative()
		bounceRight: ->
			@vel().setX @vel().x().toPositive()
		bounceDown: ->
			@vel().setY @vel().y().toNegative()
		bounceUp: ->
			@vel().setY @vel().y().toPositive()

		stopMoving: ->
			@_vel.set Vec2.zero()



	describe 'Moves', ->
		it 'moves', ->
			class X extends require './GameObject'
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
