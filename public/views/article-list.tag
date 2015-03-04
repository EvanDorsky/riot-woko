<article-list>
	<li each={ opts.articles }>
		<h2 onclick={ parent.showArticle }>{ header }</h2>
		<p>{ content }<p>
	</li>

	// logic
	var articleList = this

	articleList.new = {}

	function articleBy(id) {
		return opts.articles.find(function(art) {
			return art._id == id
		})
	}

	this.showArticle = function(e) {
		riot.route('articles/'+e.item._id)
	}

	Wiki.on('destroy-article-done', function(options) {
		var toRemove = articleBy(options.id)

		opts.articles.splice(opts.articles.indexOf(toRemove), 1)

		articleList.update()
	})

	Wiki.on('update-article-done', function(options) {
		var toUpdate = articleBy(options.id)

		toUpdate.header = options.newArticle.header
		toUpdate.content = options.newArticle.content
		
		articleList.update()
	})
</article-list>