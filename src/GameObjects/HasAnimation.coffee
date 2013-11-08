define (require) ->
	require 'meta'

	###
	Trait: HasAnimation
	Provides functions for objects that load animation data.
	TODO TEST
	###
	class HasAnimation
		@does require './Inits'

		###
		Method: init
		Loads my animation from my class name.
		###
		@onInit ->
			todo
			#@animation =
			#	loadAnimationFromName @className()

		###
		Method: step
		Tells my animation to step.
		###
		#@something
		#	@animation.step()


		null
