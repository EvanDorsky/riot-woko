<articles>
	<form id="new-article" onsubmit={ new }>
		<input class="text" name="header">
		<br>
		<textarea class="text" name="content"/>
		<input type="submit" value="New Article">
	</form>

	<div id="article-list">
		<article each={ opts.articles }/>
	</div>

	// logic
	var articles = this

	new(e) {
		$.ajax({
			type: 'POST',
			data: {
				header: $(e.target).find('[name=header]').val(),
				content: $(e.target).find('[name=content]').val()
			},
			url: '/article'
		}).done(function(article) {
			$('#article-list').prepend('<article></article>')
			riot.mount('article', article)

			$('#new-article .text').val('')
			articles.update()
		})
	}
</articles>