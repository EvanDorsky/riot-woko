window.Wiki = riot.observable();

<wiki>
	<button id="new-article" onclick={ toggleNew } if={ !newMode }>New Article</button>
	<form if={ newMode } onsubmit={ new }>
		<input class="text" name="header">
		<br>
		<textarea class="text" name="content"/>
		<input type="submit" value="New Article">
	</form>

	// logic
	var wiki = this
	wiki.newMode = false

	wiki.toggleNew = function(e) {
		wiki.newMode = !wiki.newMode

		wiki.header.value = ''
		wiki.content.value = ''
	}

	wiki.new = function(e) {
		Wiki.trigger('article-event', {
			type: 'post',
			data: {
				header: wiki.header.value,
				content: wiki.content.value
			}
		})
		wiki.toggleNew(e)
	}

	// generic model event
	// pass the type, data
	// fires appropriate done event, passing the response data and the id (if it exists)
	Wiki.on('article-event', function(options) {
		$.ajax({
			url: '/article/'+(options._id || ''),
			type: options.type,
			data: options.data || {}
		}).done(function(data) {
			Wiki.trigger(options.type+'-article-done', data,  options._id || null)
		}).error(console.error)
	})
</wiki>