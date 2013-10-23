define (require) ->
	M = require 'matrix'

	# Projection, model, and view matrices
	window.pMatrix = M.mat4.create()

	window.mvMatrix = M.mat4.create()

	window.loadMatrices = (prog) ->
		gl.uniformMatrix4fv prog.pMatrix, false, pMatrix
		gl.uniformMatrix4fv prog.mvMatrix, false, mvMatrix
