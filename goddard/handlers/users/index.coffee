# loads all the modules and the subdirs for the app
module.exports = exports = (app) ->

	# load in our modules
	require('./list')(app)
	require('./toggle')(app)