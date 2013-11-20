define (require) ->
	Moves = require './Moves'
	###
	Class: MoveSprite
	A Sprite with velocity.
	Most things should inherit from this.
	TODO TEST
	###
	Sprite = require './Sprite'

	class MoveSprite extends Sprite
		@does Moves


