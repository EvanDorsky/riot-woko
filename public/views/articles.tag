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
	var articleList = this

	new(e) {
		$.ajax({
			type: 'POST',
			data: {
				header: $(e.target).find('[name=header]').val(),
				content: $(e.target).find('[name=content]').val()
			},
			url: '/article'
		}).done(function(article) {
			opts.articles.unshift(article)

			$('#new-article .text').val('')
			articleList.update()
		})
	}
</articles>