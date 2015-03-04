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
	
	Wiki.on('delete-article-req', function(article) {
		$.ajax({
			type: 'DELETE',
			url: '/article/'+article._id
		}).done(function(res) {
			Wiki.trigger('destroy-article-done', {id:article._id})
		}).error(console.error)
	})

	Wiki.on('update-article-req', function(article) {
		$.ajax({
			type: 'PUT',
			data: article.new,
			url: '/article/'+article._id
		}).done(function(newArticle) {
			Wiki.trigger('update-article-done', {
				id: article._id,
				newArticle: newArticle
			})
		}).error(console.error)
	})
</wiki>