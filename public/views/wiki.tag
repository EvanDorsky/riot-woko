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