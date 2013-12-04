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

use = (poloJeans, pong, test, myGame) ->
	div =
		document.getElementById 'test-game'
	testGame =
		poloJeans.testGame div

	#testGame.play test_state

	# TO PLAY PONG:
	startState =
		pong.startState #to play pong
		#test.test # to run a test
		#myGame.startState # for my game

	testGame.play startState

err = (error) ->
	console.trace()
	throw error

TEST = no

if TEST
	require ['./test'], ((test) -> test()), err
else
	reqd =
		['polo-jeans',  './Pong/index', './Test/index', './MyGame/index']

	require reqd, use, err
