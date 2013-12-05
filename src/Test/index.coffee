define (require) ->
	test1: require './1' # animated thing
	test2: require './2' # animated thing pauses on enter
	test3: require './3' # makes a noise
	test4: require './4' # controllable object destroys 'foo'
	test5: require './5' # many balls, prints framerate
	test: require './5'
