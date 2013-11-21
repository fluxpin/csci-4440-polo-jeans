define (require) ->
	class Vec2
		constructor: (x, y) ->
			@setX x
			@setY y

		x: ->
			@_x

		y: ->
			@_y

		setX: (x) ->
			type x, Number
			check not isNaN x
			@_x = x

		setY: (y) ->
			type y, Number
			check not isNaN y
			@_y = y

		positive: ->
			@x() > 0 and @y() > 0

		add: (oth) ->
			type oth, Vec2
			@_x += oth._x
			@_y += oth._y

		scale: (scale) ->
			type scale, Number
			@_x *= scale
			@_y *= scale

		half: ->
			@scale 1 / 2

		addScaled: (oth, scale) ->
			@_x += oth._x * scale
			@_y += oth._y * scale

		set: (oth) ->
			@setX oth.x()
			@setY oth.y()

		copy: ->
			new Vec @x(), @y()

		moveInside: (rect) ->
			@setX @x().crop rect.left(), rect.right()
			@setY @y().crop rect.bottom(), rect.top()


		@zero = ->
			new Vec2 0, 0

		@up = (y) ->
			y ?= 1
			new Vec2 0, y

		@down = (y) ->
			y ?= 1
			@up -y

		@right = (x) ->
			x ?= 1
			new Vec2 x, 0

		@left = (x) ->
			x ?= 1
			@right -x

		toString: ->
			"<#{@x()}, #{@y()}>"


###
define (require) ->
	v2 = (require 'matrix').vec2

	glmat = GLMAT_ARRAY_TYPE ? Float32Array ? Array
###
