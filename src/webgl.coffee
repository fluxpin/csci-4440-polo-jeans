# Projection, model, and view matrices
window.pMatrix = mat4.create()
window.mvMatrix = mat4.create()

window.loadMatrices = (prog) ->
	gl.uniformMatrix4fv prog.pMatrix, false, pMatrix
	gl.uniformMatrix4fv prog.mvMatrix, false, mvMatrix
