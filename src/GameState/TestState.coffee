define (require) ->
	M = require 'matrix'
	GameObject = require 'GameObject'
	PlayState = require './GameState'

	class Dummy extends GameObject
		constructor: ->
			@angle = 0.0
			@timer = 0

		step: ->
			@angle += 0.05 # 0.05 rads ~ 3 degs ~ 180 degs/s
			if @angle >= 360.0
				@angle -= 360.0
			@timer += 1

		draw: (gl) ->
			texture = gl.textures['foo.png']

			M.mat4.rotateZ gl.mvMatrix, gl.mvMatrix, @angle
			gl.loadMatrices gl.prog

			gl.f.bindBuffer gl.f.ARRAY_BUFFER, gl.square
			gl.f.vertexAttribPointer gl.prog.vertex, 2, gl.f.FLOAT, false, 0, 0
			gl.f.bindBuffer gl.f.ARRAY_BUFFER, gl.squareTex
			gl.f.bufferSubData gl.f.ARRAY_BUFFER, 0, texture.frames[0]
			gl.f.vertexAttribPointer gl.prog.aTexCoord, 2, gl.f.FLOAT, false, 0, 0
			gl.f.activeTexture gl.f.TEXTURE0
			gl.f.bindTexture gl.f.TEXTURE_2D, texture
			gl.f.uniform1i gl.prog.tex, 0

			gl.f.drawArrays gl.f.TRIANGLE_STRIP, 0, gl.square.size

		dead: ->
			if @timer >= 200
				true
			else false



	class Pauser extends GameObject
		constructor: (state) ->
			@gameState = state
			@timer = 0
			@unpause = 0
		###
		step: ->
			@timer += 1
			if @timer > 200
				@timer = 0
				@gameState.changeState()
		###
		draw: (arg) ->
			@unpause += 1
			if @unpause > 50
				@unpause = 0
				@gameState.changeState()



	class TestState extends PlayState
		constructor: (arg) ->
			super
			@addObject new Dummy
			@addObject new Pauser(@)
