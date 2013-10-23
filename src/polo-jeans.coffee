define (require) ->
	require 'jquery'
	require 'jasmine'
	require 'matrix'
	require './webgl'

	require 'meta'
	require 'number'

	require 'GameObject/all'

	Game: require './Game/Game'
