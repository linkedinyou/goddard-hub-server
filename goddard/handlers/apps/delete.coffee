# acts as the homepage for the dashboard
module.exports = exports = (app) ->

	# the homepage for load balancer
	app.del '/apps/:appid', (req, res) -> 

		app.get('models').nodes.findAll().then((objs) ->
			res.json objs
		)