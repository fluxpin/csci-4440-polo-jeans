requirejs.config
	baseUrl: 'js'
	paths:
		jasmine: '../lib/jasmine-1.3.0/jasmine'
		'jasmine-html': '../lib/jasmine-1.3.0/jasmine-html'
		jquery: '../lib/jquery-2.0.3'
		matrix: '../lib/gl-matrix-e53ec98/gl-matrix'
		meta: './metaProgramming/index'
		GameObject: './GameObjects/index'
		GameState: './GameState'
		Vec2: './Vec2'

use = (polo_jeans) ->
	div =
		document.getElementById 'test-game'
	testGame =
		polo_jeans.testGame div

	testGame.play()

err = (error) ->
	console.trace()
	throw error

TEST = no

if TEST
	require ['./test'], (test) ->
		test()
else
	require ['polo-jeans'], use, err
