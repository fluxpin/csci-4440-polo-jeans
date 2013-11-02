define (require) ->
	M = require 'matrix'
	GameObject = require 'GameObject/GameObject'
	GameState = require './GameState'

	class Dummy extends GameObject
		constructor: ->
			@angle = 0.0

		step: ->
			@angle += 0.05 # 0.05 rads ~ 3 degs ~ 180 degs/s
			if @angle >= 360.0
				@angle -= 360.0

		draw: (gl) ->
			M.mat4.rotateZ gl.mvMatrix, gl.mvMatrix, @angle
			gl.loadMatrices gl.prog

			gl.f.bindBuffer gl.f.ARRAY_BUFFER, gl.square
			gl.f.vertexAttribPointer gl.prog.vertex, 2, gl.f.FLOAT, false, 0, 0
			gl.f.bindBuffer gl.f.ARRAY_BUFFER, gl.squareTex
			gl.f.vertexAttribPointer gl.prog.aTexCoord, 2, gl.f.FLOAT, false, 0, 0
			gl.f.activeTexture gl.f.TEXTURE0
			gl.f.bindTexture gl.f.TEXTURE_2D, gl.textures['foo.png']
			gl.f.uniform1i gl.prog.tex, 0

			gl.f.drawArrays gl.f.TRIANGLE_STRIP, 0, gl.square.size


	class TestState extends GameState
		constructor: ->
			super
			@addObject new Dummy
