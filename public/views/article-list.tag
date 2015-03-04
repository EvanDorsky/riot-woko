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

	Wiki.on('delete-article-done', function(options) {
		var toRemove = byId(options.id)

		opts.articles.splice(opts.articles.indexOf(toRemove), 1)

		articleList.update()
	})

	Wiki.on('delete-article-req', function(article) {
		$.ajax({
			type: 'DELETE',
			url: '/article/'+article._id
		}).done(function(res) {
			Wiki.trigger('delete-article-done', {id:article._id})
		}).error(console.error)
	})

	Wiki.on('update-article-done', function(options) {
		var toUpdate = byId(options.id)

		toUpdate.header = options.newArticle.header
		toUpdate.content = options.newArticle.content
		
		articleList.update()
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
</article-list>