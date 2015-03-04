<article-list>
	<li each={ opts.articles }>
		<h2 onclick={ parent.showArticle }>{ header }</h2>
		<p>{ content }<p>
	</li>

	// logic
	var articleList = this

	articleList.new = {}

	function byId(id) {
		return opts.articles.find(function(art) {
			return art._id == id
		})
	}

	this.showArticle = function(e) {
		riot.route('articles/'+e.item._id)
	}

	Wiki.on('delete-article', function (article) {
		$.ajax({
			type: 'DELETE',
			url: '/article/'+article._id
		}).done(function(res) {
			if (!res.success)
				return console.error('Failure')

			var toRemove = byId(article._id)

			opts.articles.splice(opts.articles.indexOf(toRemove), 1)

			articleList.update()
		}).error(console.error)
	})

	Wiki.on('update-article', function(article, callback) {
		$.ajax({
			type: 'PUT',
			data: article.new,
			url: '/article/'+article._id
		}).done(function(newArticle) {
			var toUpdate = byId(article._id)

			toUpdate.header = newArticle.header
			toUpdate.content = newArticle.content

			callback()
			
			articleList.update()
		}).error(console.error)
	})
</article-list>