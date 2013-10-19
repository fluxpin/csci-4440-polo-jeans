###
Class: Game
Initializes WebGL and manages all other necessary objects.
###
class window.Game
	###
	Constructor: constructor
	Creates a canvas in the provided div and initializes the global WebGL
	context. Refer to the context with *gl* (eg *gl.clearColor*).

	Parameters:
	div - The id of the div where the game should be rendered.
	x - The horizontal resolution of the game.
	y - The vertical resolution of the game.
	###
	constructor: (div, x, y) ->
		div = document.getElementById div
		canvas = document.createElement 'canvas'
		canvas.width = x
		canvas.height = y
		div.appendChild canvas

		window.gl = canvas.getContext 'experimental-webgl'
		unless gl?
			div.innerHTML = 'Unable to initialize WebGL'
		gl.clearColor 0.0, 0.0, 0.0, 1.0
