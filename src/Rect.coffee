define (require) ->
	require './number'
	Vec2 = require 'Vec2'

	class Rect
		constructor: (@_left, @_bottom, @_right, @_top) ->
			check @left() <= @right()
			check @bottom() <= @top()

		left: -> @_left
		right: -> @_right
		bottom: -> @_bottom
		top: -> @_top

		collides: (oth) ->
			type oth, Rect

			collidesX = =>
				@right() > oth.left() and @left() < oth.right()
			collidesY = =>
				@top() > oth.bottom() and @bottom() < oth.top()

			collidesX() and collidesY()

		@centered = (center, size) ->
			type center, Vec2
			type size, Vec2
			check size.positive(), ->
				"Size must be positive"

			cx = center.x()
			cy = center.y()
			w = size.x().half()
			h = size.y().half()
			new Rect cx - w, cy - h, cx + w, cy + h


	describe 'Rect', ->
		it 'collides', ->
			r1 = new Rect 0, 0, 1, 1
			r2 = new Rect 0, 0, 1, 1
			expect(r1.collides r2).toEqual yes
			#MORE!

	Rect
