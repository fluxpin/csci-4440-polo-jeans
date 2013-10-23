define (require) ->
	###
	Trait: ListensToControl
	TODO TEST, DOC
	###
	class ListensToControl
		@does (require './CallsBack'), require './Inits'

		@onDoes (user) ->
			user.extend
				###
				Class Method: onPress
				Adds a callback for when a button is pressed.
				###
				onPress: (button, func) ->
					@onKey 'presses', button, func

				###
				Class Method: onRelease
				Adds a callback for when a button is released.
				###
				onRelease: (state, func) ->
					@onKey 'releases', button, func

		###
		Method: init
		Registers me with the Controller.
		###
		@onInit ->
			37
		#	(the Controller).registerListener @

		###
		Method: isButtonDown
		Whether the given button is down.
		###
		isButtonDown: (button) ->
			(the Controller).isDown button

		###
		Method: buttonDown
		Called by Controller when a button is pushed.
		Parameters:
			button - The button that was pushed.
		###
		onButtonDown: (button) ->
			@callBackMap @onPresses, button

		###
		Method: buttonUp
		Called by Controller when a button is lifted.
		Parameters:
			button - The button that was lifted.
		###
		onButtonUp: (button) ->
			@callBackMap @onReleases, button



	describe 'ListensToControl', ->
		it 'works', ->
			class A extends GameObject
				@does ListensToControl

				@onPress 'A', ->
					@aWorked = yes

				test: ->
					@onButtonDown 'A'
					expect(@aWorked).toEqual yes

			(new A).test()
