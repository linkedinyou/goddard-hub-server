# loads all the modules and the subdirs for the app
module.exports = exports = (app) ->

	# require the modules
	_ 			= require('underscore')

	# handle any metric coming our way
	app.get '/apps.json', (req, res) ->

		# get the nodeid
		node_id_str = req.query.uid or req.query.nodeid or null

		# find the node by that id
		app.get('models').nodes.find(1 * node_id_str).then((item_obj) =>

			# get the details
			node_obj = item_obj.get()

			console.dir(node_obj)

			# create / find a node
			app.get('sequelize_instance')
			.query('SELECT apps.* FROM installs,apps where installs."appId"=apps.id AND "groupId"=' + node_obj.groupId + " GROUP BY apps.id")
			.then((app_objs) ->

				# public app output
				public_app_objs = []

				# write then output our apps
				for app_obj in app_objs[0]

					console.dir app_obj

					# generate the domain to use
					domain_str = app_obj.key + '.goddard.com'

					# if this is a portal app
					if app_obj.portal == true
						domain_str = 'goddard.com'

					# append it
					public_app_objs.push({

						'name': app_obj.name,
						'description': app_obj.description,
						'domain': domain_str,
						'port': 6100 + app_obj.id,
						'internal': app_obj.visible == false,
						'key': app_obj.key,
						'id': app_obj.id

					})

				# output them
				res.json public_app_objs

			)

		)