define (require) ->
	class Controller extends require './GameObject'
		constructor: ->
			document.addEventListener 'keydown', (event) => @keyDown event
			document.addEventListener 'keyup', (event) => @keyUp event

		keyDown: (event) ->
			todo()

		keyUp: (event) ->
			todo()

		addListener: (listener) ->
			todo()

		isButtonDown: (buttonName) ->
			todo()

###
function registerListener(input_type, key_code, func_to_add) {
	//input_type should be 'keydown' or 'keyup'
	//key_code is int representing key pressed -->
	//	will be string in the future but need to create translator to change
	//	name of key to keyCode
	//func_to_add is the desired function to be called when input is given
	document.addEventListener(input_type, function(event) {
		if(event.keyCode==key_code) {
			func_to_add();
		}
		return true;
	});
	return true;
}
###
