requirejs.config
	baseUrl: 'js'
	paths:
		jasmine: '../lib/jasmine-1.3.0/jasmine'
		jquery: '../lib/jquery-2.0.3'
		matrix: '../lib/gl-matrix-e53ec98/gl-matrix'
		meta: './metaProgramming/all'
		Loader: './Loader'
		GameObject: './GameObject'
		GameState: './GameState'

use = (polo_jeans) ->
	div =
		document.getElementById 'test-game'
	testGame =
		polo_jeans.testGame div

	testGame.play()

err = (error) ->
	console.trace()
	throw error

require ['polo-jeans'], use, err
