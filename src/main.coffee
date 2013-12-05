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

GAME =
	'pong' # 'test' # 'myGame'

# Turn this on to have Jasmine run tests (no game)
TEST = no

use = (poloJeans, pong, test, myGame) ->
	div =
		document.getElementById 'test-game'
	testGame =
		poloJeans.testGame div

	# TO PLAY PONG:
	startState =
		switch GAME
			when 'pong'
				pong.startState
			when 'test'
				test.test
			when 'myGame'
				myGame.startState

	testGame.play startState

err = (error) ->
	console.trace()
	throw error

if TEST
	require ['./test'], ((test) -> test()), err
else
	reqd =
		['polo-jeans',  './Pong/index', './Test/index', './MyGame/index']

	require reqd, use, err
