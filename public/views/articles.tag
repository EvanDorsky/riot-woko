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

	Wiki.on('delete-article', function (article) {
		$.ajax({
			type: 'DELETE',
			url: '/article/'+article._id
		}).done(function(res) {
			if (!res.success)
				return console.error('Failure')

			var toRemove = opts.articles.find(function(art) {
				return art._id == article._id
			})

			opts.articles.splice(opts.articles.indexOf(toRemove), 1)

			articleList.update()
		}).error(console.error)
	})

	Wiki.on('update-article', function(article, callback) {
		$.ajax({
			type: 'PUT',
			data: {
				header: article.new.header,
				content: article.new.content
			},
			url: '/article/'+article._id
		}).done(function(newArticle) {
			var toUpdate = opts.articles.find(function(art) {
				return art._id == article._id
			})

			toUpdate.header = newArticle.header
			toUpdate.content = newArticle.content

			callback()
			
			articleList.update()
		}).error(console.error)
	})

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
		}).error(console.error)
	}
</articles>