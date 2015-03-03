<articles>
	<form onsubmit={ new }>
		<input name="header" onkeyup={ input }>

		<input name="content" onkeyup={ input }>

		<input type="submit" value="New Article">
	</form>

	<article each={ opts.articles }/>

	// logic
	var editor = this

	editor.new = {}

	input(e) {
		editor.new[e.target.name] = e.target.value
	}

	new(e) {
		$.ajax({
			type: 'POST',
			data: editor.new,
			url: '/article'
		}).done(function(article) {
			$('body').append('<article></article>')
			riot.mount('article', article)
		})
	}
</articles>