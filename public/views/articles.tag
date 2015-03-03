<articles>
	<form id="new-article" onsubmit={ new }>
		<input class="text" name="header" onkeyup={ input }>
		<br>
		<textarea class="text" name="content" onkeyup={ input }/>
		<input type="submit" value="New Article">
	</form>

	<div id="article-list">
		<article each={ opts.articles }/>
	</div>

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
			$('#article-list').prepend('<article></article>')
			riot.mount('article', article)

			$('#new-article .text').val('')
		})
	}
</articles>