define (require) ->
	Moves = require './Moves'
	Sprite = require './Sprite'

	###
	Class: MoveSprite
	A Sprite with velocity.
	Most things should inherit from this.
	###
	class MoveSprite extends Sprite
		@does Moves


