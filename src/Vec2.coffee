define (require) ->
	class Vec2
		constructor: (x, y) ->
			unless x?
				x = y = 0
			type x, Number
			type y, Number
			@_x = x
			@_y = y

		x: ->
			@_x
		y: ->
			@_y

		add: (oth) ->
			type oth, Vec2
			@_x += oth._x
			@_y += oth._y

		scale: (scale) ->
			type scale, Number
			@_x *= scale
			@_y *= scale

		addScaled: (oth, scale) ->
			@_x += oth._x * scale
			@_y += oth._y * scale

		setTo: (oth) ->
			@_x = oth._x
			@_y = oth._y

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


###
define (require) ->
	v2 = (require 'matrix').vec2

	glmat = GLMAT_ARRAY_TYPE ? Float32Array ? Array
###
