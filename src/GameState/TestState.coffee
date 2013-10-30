define (require) ->
	M = require 'matrix'

	class Dummy extends require 'GameObject/GameObject'
		constructor: ->
			@angle = 0

		step: ->
			@angle += 0.01

		draw: (graphics) ->
			g = graphics

			M.mat4.rotateZ g.mvMatrix, g.mvMatrix, @angle
			g.loadMatrices g.prog

			g.gl.bindBuffer g.gl.ARRAY_BUFFER, g.square
			g.gl.vertexAttribPointer g.prog.vertex, 2, g.gl.FLOAT, false, 0, 0
			g.gl.bindBuffer g.gl.ARRAY_BUFFER, g.squareTex
			g.gl.vertexAttribPointer g.prog.aTexCoord, 2, g.gl.FLOAT, false, 0, 0
			g.gl.activeTexture g.gl.TEXTURE0
			g.gl.bindTexture g.gl.TEXTURE_2D, g.textures['foo.png']
			g.gl.uniform1i g.prog.tex, 0

			g.gl.drawArrays g.gl.TRIANGLE_STRIP, 0, g.square.size


	class TestState extends require './GameState'
		constructor: ->
			super
			@addObject new Dummy
