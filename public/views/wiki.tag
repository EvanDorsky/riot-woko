window.Wiki = riot.observable();

<wiki>
	Wiki.newMode = false
  Wiki.editMode = false

	// generic model event
	// pass the type, data
	// fires appropriate done event, passing the response data and the id (if it exists)
	Wiki.on('article-event', function(options) {
		$.ajax({
			url: '/article/'+(options._id || ''),
			type: options.type,
			data: options.data || {}
		}).done(function(data) {
			Wiki.trigger(options.type+'-article-done', data, options._id || null)
		}).error(console.error)
	})

  Wiki.on('toggle-edit', function() {
    Wiki.editMode = !Wiki.editMode
    riot.update()
  })

  Wiki.on('toggle-new', function() {
    Wiki.newMode = !Wiki.newMode
    riot.update()
  })

	Wiki.login = function() {
		window.location = '/olinauth/login'
		Wiki.trigger('login')
	}

	Wiki.logout = function() {
		window.location = '/olinauth/logout'
		Wiki.trigger('logout')
	}
</wiki>