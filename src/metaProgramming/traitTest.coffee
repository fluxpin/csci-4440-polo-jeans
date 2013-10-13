describe 'traits', ->
	class A
		twice_a: ->
			@a * 2

	class B

		twice_b: ->
			@b * 2

	class CollidesWithTwiceA
		twice_a: ->
			8

	class Super

	class AB extends Super
		constructor: ->
			@a = 1
			@b = 2

		twice: ->
			@twice_a() + @twice_b()

		@does A, B

	class AbstractRequirer
		abstract_method: abstract

	class AbstractImplementor
		@does AbstractRequirer

	it 'many traits merge', ->
		class W
			@listAdd 'l', 'w'
		class X extends W
			@listAdd 'l', 'x'
		class Y
			@does W
			@listAdd 'l', 'y'
		class Z extends X
			@does Y
			@listAdd 'l', 'z'
		expected = new TraitMergingList
		['w', 'x', 'y', 'z'].forEach (x) ->
			expected.add x
		expect((new Z).l).toEqual expected

	it 'isA', ->
		ab = new AB
		expect(ab.isA A).toEqual yes
		expect(ab.isA B).toEqual yes
		expect(ab.isA Super).toEqual yes
		expect(ab.isA Array).toEqual no

	it 'traits can be inherited twice', ->
		class X
			@does A, A

	it 'works good', ->
		class X
		class Y
			@does X
		class Z
			@does Y
		class XY
			@does X, Y

		expect((new Z).traits).toEqual (new XY).traits


	it "can't collide 'does' (without precede)", ->
		expect(-> CollidesWithTwiceA.does A).toThrow()

	it "'does' only works with constructor.does(trait)", ->
		expect(-> 1.does A).toThrow()
		expect(-> AB.does 1).toThrow()

	it "class 'does' trait", ->
		ab = new AB
		expect(ab.a).toEqual 1
		expect(ab.twice_a()).toEqual 2
		expect(ab.twice_b()).toEqual 4
		expect(ab.twice()).toEqual 6

	it 'abstract methods throw error', ->
		expect(-> (new AbstractImplementor).abstract_method()).toThrow()

