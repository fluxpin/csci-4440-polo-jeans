{ exec } = require 'child_process'

execHandle = (after) ->
	(err, stdout, stderr) ->
		console.log stdout + stderr
		if err?
			throw err
		after()

run = (command) ->
	(after) ->
		console.log "RUNNING #{command}"
		exec command, execHandle after

clean =
	run 'rm -rf doc js'

build =
	run 'coffee  --compile --bare --output js src'

lint =
	run 'coffeelint -f script/lintConfig.json src/*.coffee src/*/*.coffee src/*/*/*.coffee'

readyDoc =
	run 'mkdir doc doc/project'

doDoc =
	run '''
		script/NaturalDocs-1.52/NaturalDocs
			--input src
			--output HTML doc
			--project doc/project
			--rebuild
	'''.replace /\n\t/g, ' '


task 'all', 'Description', ->
	clean -> build -> lint -> readyDoc -> doDoc ->
		console.log 'Done!'

