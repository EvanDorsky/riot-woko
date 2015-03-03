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

	editor.newInfo = {}

	// this causes update of articles which causes bad data
	input(e) {
		editor.newInfo[e.target.name] = e.target.value
	}

	new(e) {
		$.ajax({
			type: 'POST',
			data: editor.newInfo,
			url: '/article'
		}).done(function(article) {
			$('#article-list').prepend('<article></article>')
			riot.mount('article', article)

			editor.newInfo = {}
			$('#new-article .text').val('')
			riot.update()
		})
	}
</articles>