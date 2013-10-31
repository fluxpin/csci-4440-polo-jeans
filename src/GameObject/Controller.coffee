define (require) ->
	class Controller extends require './GameObject'
		constructor: ->
			currentlyPressedKeys = {}
			document.addEventListener 'keydown', (event) => @keyDown event
			document.addEventListener 'keyup', (event) => @keyUp event

		keyDown: (event) ->
			currentlyPressedKeys[event.keyCode] = true

		keyUp: (event) ->
			currentlyPressedKeys[event.keyCode] = false

		addListener: (listener) ->
			todo()

		isButtonDown: (buttonCode) ->
			#will change back to string input rater than int for final version
			currentlyPressedKeys[buttonCode]
