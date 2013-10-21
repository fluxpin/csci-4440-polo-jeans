###
Class: Loader
Requests an index of some type of resource from the server, then requests
all available instances of that resource. Each instance is processed, then
passed to the provided callback along with an index entry and an indication
of whether to expect more instances.
###
class window.Loader
	###
	Variable: sync
	Holds the total number of resource instances. Enables notifying the
	receiving callback when loading is complete.
	###
	sync: 0

	###
	Constructor: constructor
	Asynchronously loads, processes, and returns resources via the provided
	callback.

	Parameters:
	path - The path to the top-level directory for the relevant resource.
	callback - A function (*callback: (res, entry, done) ->*) that will
	accept resources.
	###
	constructor: (@path, @callback) ->
		indexReq = new XMLHttpRequest()
		indexReq.open 'GET', "#{@path}/index.json"
		indexReq.responseType = 'json'
		indexReq.onload = =>
			@sync = indexReq.response.length
			indexReq.response.forEach @load
		indexReq.send null

	###
	Method: load
	Loads the resource specified by the provided path and entry. Each time
	this method is called it must in turn call *@process*.

	Parameters:
	entry - An index entry specifying a resouce instance.
	###
	load: (entry) =>

	###
	Method: process
	Processes the provided resource. Each time this method is called it must
	in turn call *@callback*. Each time this method is called it must
	decrement *@sync*.

	Parameters:
	res - A resource.
	entry - An index entry specifying the resource instance.
	###
	process: (res, entry) ->
