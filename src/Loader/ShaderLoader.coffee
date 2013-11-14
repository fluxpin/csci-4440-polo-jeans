define (require) ->
	$ = require 'jquery'
	Loader = require './Loader'

	getText = (url) ->
		$.get url, undefined, undefined, 'text'

	###
	Class: ShaderLoader
	###
	class ShaderLoader extends Loader
		constructor: (@_path, @gl) ->

		#
		_load: (entry) ->
			source = getText "#{@_path}/#{entry.name}"
			source.then (source) ->
				[entry, source]

		#
		_process: (entry, source) ->
			if entry.type is 'vertex'
				shader = @gl.f.createShader @gl.f.VERTEX_SHADER
			else
				shader = @gl.f.createShader @gl.f.FRAGMENT_SHADER
			shader.name = entry.name
			@gl.f.shaderSource shader, source
			@gl.f.compileShader shader
			unless @gl.f.getShaderParameter shader, @gl.f.COMPILE_STATUS
				console.log @gl.f.getShaderInfoLog shader
			shader
