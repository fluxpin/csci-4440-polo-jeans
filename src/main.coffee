requirejs.config
	#By default load any module IDs from js
	baseUrl: 'js',

	paths:
		jquery: '../lib/jquery-2.0.3'
		jasmine: '../lib/jasmine-1.3.0/jasmine'
		matrix: '../lib/gl-matrix-e53ec98/gl-matrix'
		meta: './metaProgramming/all'
		Loader: './Loader'
		GameObject: './GameObject'


use = (polo_jeans) ->
	testGame = new polo_jeans.Game 'test-game', 800, 600
	testGame.play()

err = (error) ->
	console.trace()
	throw error

require ['polo-jeans'], use, err
