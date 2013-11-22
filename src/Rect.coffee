define (require) ->
	require './number'
	Vec2 = require 'Vec2'

	oppositeSide = (side) ->
		switch side
			when 'left'
				'right'
			when 'right'
				'left'
			when 'up'
				'down'
			when 'down'
				'up'

	###
	Class: Rect
	An axis-aligned rectangle.
	Immutable.
	###
	class Rect
		constructor: (@_left, @_bottom, @_right, @_top) ->
			check @left() <= @right()
			check @bottom() <= @top()
			Object.freeze @

		###
		Method: left
		Leftmost x.
		###
		left: -> @_left

		###
		Method: right
		Rightmost x.
		###
		right: -> @_right

		###
		Method: bottom
		Lowest y.
		###
		bottom: -> @_bottom

		###
		Method: top
		Highest y.
		###
		top: -> @_top

		###
		Method: centerX
		###
		centerX: ->
			@left().average @right()

		###
		Method: centerY
		###
		centerY: ->
			@bottom().average @top()

		###
		Method: center
		###
		center: ->
			new Vec2 @centerX(), @centerY()

		###
		Method: width
		Distance from left to right side.
		###
		width: ->
			@right() - @left()

		###
		Method: height
		Distance from bottom to top.
		###
		height: ->
			@top() - @bottom()

		###
		Method: collides
		Whether I and another rect have any intersection.
		collideSide finds how we collided.
		###
		collides: (oth) ->
			type oth, Rect

			collidesX = =>
				@right() > oth.left() and @left() < oth.right()
			collidesY = =>
				@top() > oth.bottom() and @bottom() < oth.top()

			collidesX() and collidesY()

		###
		Method: smallerBy
		Myself, reduced in size by dec.
		I must be larger than dec.
		###
		smallerBy: (dec) ->
			type dec, Vec2
			w = dec.x().half()
			h = dec.y().half()
			new Rect @left() + w, @bottom() + h, @right() - w, @top() - h

		###
		Method: collideSide
		What side another rect is relative to me.
		Assumes we are colliding (doesn't check).
		Returns one of: 'left', 'right', 'bottom', 'top'.
		###
		collideSide: (r) ->
			type r, Rect
			# what sides of r are inside me?
			lIn = r.left() >= @left()
			rIn = r.right() <= @right()
			bIn = r.bottom() >= @bottom()
			tIn = r.top() <= @top()

			if lIn
				if rIn
					if tIn
						if bIn
							#it's inside me
							@vecSide r.center()
						else
							'bottom'
					else
						if bIn
							'top'
						else
							@vecSide r.center()
				else # lIn but not rIn
					if tIn
						if bIn
							'right'
						else
							# r's left-top is in me. Where is that relative to my right-bottom?
							if @right() - r.left() > r.top() - @bottom()
								'bottom'
							else
								'right'
					else # lIn but not rIn or tIn
						if bIn
							# r's left-bottom is in me. Where is that relative to my right-top?
							if @right - r.left() > @top() - r.bottom()
								'top'
							else
								'right'
						else
							'right' #only lIn
			else #not lIn
				if rIn
					if tIn
						if bIn
							'left'
						else
							# r's right-top is in me. Where is that relative to my left-bottom?
							if r.right() - @left() > r.top() - @bottom()
								'bottom'
							else
								'left'
					else #rIn but not lIn or tIn
						if bIn
							# r's right-bottom is in me. Where is that relative to my left-top?
							if r.right() - @left() > @top() - r.bottom()
								'top'
							else
								'left'
						else
							'left'
				else # neighter lIn nor rIn
					if tIn
						if bIn
							@vecSide r.center()
						else
							'bottom'
					else # neither lIn nor rIn nor tIn
						if bIn
							'top'
						else
							oppositeSide @vecSide r.center()

		###
		Method: vecSide
		What side a Vec2 is relative to me.
		###
		vecSide: (v) ->
			relX = (v.x() - @center().x()) * @height()
			relY = (v.y() - @center().y()) * @height()

			if relX.abs > relY.abs
				if relX.negative()
					'left'
				else
					'right'
			else
				if relY.negative()
					'bottom'
				else
					'top'

		###
		Class Method: centered
		Rect centered at center and of size size.
		###
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
