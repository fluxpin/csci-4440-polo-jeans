define (require) ->
	class Vec2
		constructor: (x, y) ->
			@setX x
			@setY y

		###
		Method: x
		Amount right of the origin.
		###
		x: ->
			@_x

		###
		Method: y
		Amount above the origin.
		###
		y: ->
			@_y

		###
		Method: setX
		Set new x value. Can not be NaN.
		###
		setX: (x) ->
			type x, Number
			check not isNaN x
			@_x = x


		###
		Method: setY
		Set new y value. Can not be NaN.
		###
		setY: (y) ->
			type y, Number
			check not isNaN y
			@_y = y

		###
		Method: magnitude
		Vector length.
		###
		magnitude: ->
			(@x().square() + @y().square()).squareRoot()

		###
		Method: positive
		Whether the vector points to the first quadrant.
		###
		positive: ->
			@x() > 0 and @y() > 0

		###
		Method: add
		Alter me by adding oth.
		###
		add: (oth) ->
			type oth, Vec2
			@_x += oth._x
			@_y += oth._y

		###
		Method: scale
		Alter me by scaling magnitude.
		###
		scale: (scale) ->
			type scale, Number
			@_x *= scale
			@_y *= scale

		###
		Method: half
		Become half as long.
		###
		half: ->
			@scale 1 / 2

		###
		Method: addScaled
		###
		addScaled: (oth, scale) ->
			@_x += oth._x * scale
			@_y += oth._y * scale

		###
		Method: set
		Set the value of this Vec2 to that of another.
		###
		set: (oth) ->
			@setX oth.x()
			@setY oth.y()

		###
		Method: copy
		Produces an identical Vec2.
		###
		copy: ->
			new Vec @x(), @y()

		###
		Method: moveInside
		Restricts my range to the inside of a Rect.
		###
		moveInside: (rect) ->
			@setX @x().crop rect.left(), rect.right()
			@setY @y().crop rect.bottom(), rect.top()

		###
		Class Method: zero
		Vector of no length.
		###
		@zero = ->
			new Vec2 0, 0

		###
		Class Method: up
		Vector pointing up, of length y (default 1).
		###
		@up = (y) ->
			y ?= 1
			new Vec2 0, y

		###
		Class Method: down
		Vector pointing down, of length y (default 1).
		###
		@down = (y) ->
			y ?= 1
			@up -y

		###
		Class Method: left
		Vector pointing left, of length x (default 1).
		###
		@left = (x) ->
			x ?= 1
			@right -x

		###
		Class Method: right
		Vector pointing right, of length x (default 1).
		###
		@right = (x) ->
			x ?= 1
			new Vec2 x, 0

		toString: ->
			"<#{@x()}, #{@y()}>"
