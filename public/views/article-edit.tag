<article-edit>
	<form onsubmit={ edit }>
		<input name="header" onkeyup={ input }>

		<input name="content" onkeyup={ input }>

		<input type="submit">
	</form>

	// logic
	var editor = this

	editor.new = {}

	input(e) {
		editor.new[e.target.name] = e.target.value
	}

	edit(e) {
		console.log("editor.new")
		console.log(editor.new)
		$.ajax({
			type: 'PUT',
			data: {
				header: editor.new.header,
				content: editor.new.content
			},
			url: '/article'
		}).done(function(newArticle) {
			$('body').append('<article></article>')
			riot.mount('article', newArticle)
		});
	}
</article-edit>