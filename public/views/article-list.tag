<article-list>
	<ul if={ opts.authed }>
		<li each={ opts.articles }>
			<h2 class="art-head" onclick={ parent.showArticle }>{ header }</h2>
			<raw content={ content }/>
		</li>
	</ul>
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

	// model event handling

	Wiki.on('put-article-done', function(newArticle, _id) {
		var toUpdate = articleBy(_id)

		toUpdate.header = newArticle.header
		toUpdate.source = newArticle.source
		toUpdate.content = newArticle.content
		
		articleList.update()
	})

	Wiki.on('post-article-done', function(newArticle) {
		opts.articles.unshift(newArticle)

		articleList.update()
	})

	Wiki.on('delete-article-done', function(data, id) {
		var toRemove = articleBy(id)

		opts.articles.splice(opts.articles.indexOf(toRemove), 1)

		articleList.update()
	})
</article-list>