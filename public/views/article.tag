<article>
	<p if={ !opts.authed }>Please log in to view the wiki.</p>
	<div if={ (!Wiki.editMode && !Wiki.newMode ) && opts.authed }>
		<h2>{ this.header }</h2>
		<raw class="content" content={ this.content }/>
		<p>—{ this.author }</p>
	</div>
	<form if={ Wiki.editMode || Wiki.newMode }>
		<input name="headerin">
		<textarea name="sourcein"/>
	</form>

	// logic
	var article = this

	if (!opts.authed)
		return

	this._id = opts.article._id
	this.header = opts.article.header
	this.content = opts.article.content
	this.source = opts.article.source
	this.author = opts.article.author

	function articleBy(id) {
		return opts.articles.find(function(art) {
			return art._id == id
		})
	}

	riot.route(function(collection, id, action) {
		if (!action) {
			var newArticle = articleBy(id)

			article._id = id
			article.header = newArticle.header
			article.content = newArticle.content
			article.author = newArticle.author

			article.update()
		}
	})

  Wiki.on('article-submit', function() {
    var parsed = marked(article.sourcein.value)

    Wiki.trigger('article-event', {
      type: Wiki.newMode? 'post' : 'put',
      data: {
        header: article.headerin.value,
        source: article.sourcein.value,
        content: parsed
      },
      _id: Wiki.newMode? null : article._id
    })
  })

	// model event triggering and handling

  Wiki.on('toggle-edit', function() {
    article.headerin.value = article.header
    article.sourcein.value = article.source

    article.update()
  })

  Wiki.on('put-article-done', function(newArticle) {
    article.header = newArticle.header
    article.content = newArticle.content
    article.source = newArticle.source
    article.author = newArticle.author

    Wiki.trigger('toggle-edit')
  })

	Wiki.on('post-article-init', function() {
		article.headerin.value = ''
		article.sourcein.value = ''

		article.update()
	})

  Wiki.on('post-article-done', function(newArticle) {
    Wiki.trigger('toggle-new')
  })

  Wiki.on('delete-article-init', function() {
    Wiki.trigger('article-event', {
      type: 'delete',
      _id: article._id
    })
  })

	Wiki.on('delete-article-done', function(data, id) {
		if (opts.articles)
			riot.route('articles/'+opts.articles[0]._id)
		else
			console.log("punting for now, wiki is empty")
	})
</article>