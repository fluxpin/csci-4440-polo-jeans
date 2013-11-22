define (require) ->
	extend = (require 'jquery').extend

	###
	Const: TwoPi
	Twice Math.Pi.
	###
	Number.TwoPi =
		Math.PI * 2

	###
	Func: randomFrom
	Random number in range [min ... max).
	###
	Number.randomFrom = (min, max) ->
		Math.random() * (max - min) + min


	###
	Class: Number
	###

	###
	Method: floor
	Biggest integer no bigger than me.
	###
	###
	Method: ceil
	Smallest integer no smaller than me.
	###
	###
	Method: cos
	Cosine.
	###
	###
	Method: sin
	Sine.
	###
	###
	Method: abs
	Force a number to be positive.
	###
	#
	["abs", "floor", "ceil", "cos", "sin"].forEach (name) ->
		Number.prototype[name] = ->
			Math[name] @

	extend Number.prototype,
		###
		Method: average
		Mid-point between me and another Number.
		###
		average: (oth) ->
			type oth, Number
			(@ + oth).half()

		###
		Method: crop
		Push this to be within [inclusive] a min and max.
		###
		crop: (min, max) ->
			check min <= max, ->
				"min must be <= max, but #{min} > #{max}"
			if @ < min
				min
			else if @ > max
				max
			else
				@valueOf()

		###
		Method: diff
		Distance between two numbers.
		###
		diff: (x) ->
			(@ - x).abs()

		###
		Method: half
		1/2 of me.
		###
		half: ->
			@ / 2

		###
		Method: oppositeSign
		Whether two numbers are on different sides of zero.
		###
		oppositeSign: (oth) ->
			(@ * oth) < 0

		###
		Method: negative
		###
		negative: ->
			@ < 0

		###
		Method: positive
		###
		positive: ->
			@ > 0

		###
		Method: toNegative
		If I am negative, does nothing. Else, negates me.
		###
		toNegative: ->
			-@abs()

		###
		Method: toPositive
		If I am positive, does nothing. Else, negates me.
		###
		toPositive: ->
			@abs()

		###
		Method: scaleFrom
		A value on a scale from oldMin -- oldMax
			is moved to a scale from newMin -- newMax
		###
		scaleFrom: (oldMin, oldMax, newMin, newMax) ->
			zeroToOne =
				(@ - oldMin) / (oldMax - oldMin)

			newMin + zeroToOne * (newMax - newMin)

		###
		Method: scaleCropped
		Scale a number from one range to another.
		If this leaves it outside of the new range, crop it.
		###
		scaleCropped: (oldMin, oldMax, newMin, newMax) ->
			(@scaleFrom oldMin, oldMax, newMin, newMax).crop newMin, newMax

		###
		Method: square
		Product of me and myself.
		###
		square: ->
			@ * @

		###
		Method: squareRoot
		Number whose square is me.
		###
		squareRoot: ->
			Math.sqrt @

		###
		Method: toIntString
		Rounded me to an int and stringified.
		###
		toIntString: ->
			@toFixed()


	describe 'number', ->
		it 'works', ->
			expect(2.crop 3, 4).toEqual 3
			expect(3.5.crop 3, 4).toEqual 3.5
			expect(100.crop 3, 4).toEqual 4

			expect(1.diff 3).toEqual 2
			expect(100.diff -5).toEqual 105

			expect(1.oppositeSign -1).toEqual yes
			expect(0.oppositeSign 0).toEqual no
			expect(1.oppositeSign 1).toEqual no

			expect(2.5.scaleFrom 1, 3, 10, 50).toEqual 40

			expect((-2).square()).toEqual 4

			expect(1.5.toIntString()).toEqual '2'
