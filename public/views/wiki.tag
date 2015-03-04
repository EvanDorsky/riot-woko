window.Wiki = riot.observable();

<wiki>
	<form id="new-article" onsubmit={ new }>
		<input class="text" name="header" onkeyup={ input }>
		<br>
		<textarea class="text" name="content" onkeyup={ input }/>
		<input type="submit" value="New Article">
	</form>

	// logic
	var wiki = this

	wiki.new = {}

	this.input = function(e) {
		wiki.new[e.target.name] = e.target.value
	}

	function byId(id) {
		return opts.articles.find(function(art) {
			return art._id == id
		})
	}

	riot.route(function(collection, id, action) {
		if (!action) {// show
			var article = byId(id)
			console.log("article")
			console.log(article)
		}
	})

	new(e) {
		$.ajax({
			type: 'POST',
			data: wiki.new,
			url: '/article'
		}).done(function(article) {
			opts.articles.unshift(article)

			$('#new-article .text').val('')
			riot.update()
		}).error(console.error)
	}
</wiki>