define (require) ->
	Loader = require './Loader'

	###
	Class: ShaderLoader
	Loads and compiles shaders.
	###
	class ShaderLoader extends Loader
		###
		Method: constructor
		Asynchronously loads, compiles, and returns shaders via the provided
		callback.

		Parameters:
		callback - A function (*callback: (shader, entry, done) ->*) that will
		accept shaders.
		###
		constructor: (@gl, callback) ->
			super '/res/shaders', callback

		###
		Method: load
		Loads the shader specified by the provided path and entry.

		Parameters:
		entry - An index entry specifying a shader.
		###
		load: (entry) =>
			shaderReq = new XMLHttpRequest()
			shaderReq.open 'GET', "#{@path}/#{entry.name}"
			shaderReq.onload = =>
				@process shaderReq.response, entry
			shaderReq.send null

		###
		Method: process
		Compiles the provided shader.

		Parameters:
		source - A shader.
		entry - An index entry specifying the shader.
		###
		process: (source, entry) ->
			if entry.type is 'vertex'
				shader = @gl.createShader @gl.VERTEX_SHADER
			else
				shader = @gl.createShader @gl.FRAGMENT_SHADER
			@gl.shaderSource shader, source
			@gl.compileShader shader
			unless @gl.getShaderParameter shader, @gl.COMPILE_STATUS
				console.log @gl.getShaderInfoLog shader
			@sync = @sync - 1
			@callback shader, entry, if @sync then false else true
