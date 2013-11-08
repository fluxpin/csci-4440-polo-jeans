define (require) ->
	Moves = require './Moves'
	###
	Class: MoveSprite
	A Sprite with velocity.
	Most things should inherit from this.
	TODO TEST
	###
	class window.MoveSprite extends require './Sprite'
		@does Moves

		init: ->
