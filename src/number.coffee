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
Function: floor
Biggest integer no bigger than me.
###
###
Function: ceil
Smallest integer no smaller than me.
###
###
Function: cos
Cosine.
###
###
Function: sin
Sine.
###
###
Function: abs
Force a number to be positive.
###
#
["abs", "floor", "ceil", "cos", "sin"].forEach (name) ->
	Number.prototype[name] = ->
		Math[name] @


Number.prototype.extend
	###
	Func: crop
	Push this to be within [inclusive] a min and max.
	eg
		(2.crop 3, 4) == 3
		(3.5.crop 3, 4) == 3.5
		(100..crop 3, 4) == 4
	###
	crop: (min, max) ->
		check min < max, ->
			"min must be < max, but #{min} >= #{max}"
		if @ < min
			min
		else if @ > max
			max
		else
			@valueOf()

	###
	Func: diff
	Distance between two numbers.
	eg
		1.diff 3 == 2
		100.diff -5 == 105
	###
	diff: (x) ->
		(@ - x).abs

	###
	Func: oppositeSign
	Whether two numbers are on different sides of zero.
	eg
		1.oppositeSign -1
		not 0.oppositeSign 0
		1.oppositeSign 1
	###
	oppositeSign: (oth) ->
		(@ * oth) < 0

	###
	Func: scaleFrom
	A value on a scale from oldMin -- oldMax
		is moved to a scale from newMin -- newMax
	eg
		assert (2.5.scaleFrom 1, 3, 10, 50) == 40
	###
	scaleFrom: (oldMin, oldMax, newMin, newMax) ->
		zeroToOne =
			(@ - oldMin) / (oldMax - oldMin)

		newMin + zeroToOne * (newMax - newMin)

	###
	Func: scaleCropped
	Scale a number from one range to another.
	If this leaves it outside of the new range, crop it.
	###
	scaleCropped: (oldMin, oldMax, newMin, newMax) ->
		(@scaleFrom oldMin, oldMax, newMin, newMax).crop newMin, newMax

	###
	Func: square
	Product of a number and itself.
	###
	square: ->
		@ * @

	###
	Func: toIntString
	Number rounded to an int and stringified.
	Ex. 1.5 -> "2"
	###
	toIntString: ->
		@toFixed()



if TEST
	"TODO"
