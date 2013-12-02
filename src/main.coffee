requirejs.config
	baseUrl: 'js'
	paths:
		jasmine: '../lib/jasmine-1.3.0/jasmine'
		'jasmine-html': '../lib/jasmine-1.3.0/jasmine-html'
		jquery: '../lib/jquery-2.0.3'
		matrix: '../lib/gl-matrix-e53ec98/gl-matrix'
		meta: './metaProgramming/index'
		GameObject: './GameObjects/index'
		GameState: './GameStates/index'
		Vec2: './Vec2'
		Rect: './Rect'

use = (polo_jeans, pong, test) ->
	div =
		document.getElementById 'test-game'
	testGame =
		polo_jeans.testGame div

	#testGame.play test_state
	testGame.play test.test # pong.startState

err = (error) ->
	console.trace()
	throw error

TEST = no

if TEST
	require ['./test'], ((test) -> test()), err
else
	require ['polo-jeans',  './Pong/index', './Test/index'], use, err
