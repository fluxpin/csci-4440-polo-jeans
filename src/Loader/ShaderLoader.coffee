define (require) ->
	$ = require 'jquery'
	Loader = require 'Loader/Loader'

	# Get text data using an AJAX request
	getText = (url) ->
		$.get url, undefined, undefined, 'text'

	###
	Class: ShaderLoader
	Load WebGL vertex and fragment shaders.
	###
	class ShaderLoader extends Loader
		###
		Method: constructor
		Parameters:
		path - Path to the resource's top-level directory.
		gl - Graphics object representing the game's WebGL context.
		###
		constructor: (@_path, @_gl) ->

		# Load shader source code
		_load: (entry) ->
			getText("#{@_path}/#{entry.name}").then (source) ->
				[entry, source]

		# Compile shader source code
		_process: (entry, source) ->
			gl = @_gl.f

			if entry.type is 'vertex'
				shader = gl.createShader gl.VERTEX_SHADER
			else if entry.type is 'fragment'
				shader = gl.createShader gl.FRAGMENT_SHADER
			else
				fail 'Invalid or unsupported shader type!'

			shader.name = entry.name
			gl.shaderSource shader, source
			gl.compileShader shader
			unless gl.getShaderParameter shader, gl.COMPILE_STATUS
				fail gl.getShaderInfoLog shader
			shader
