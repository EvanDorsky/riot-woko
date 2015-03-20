<article>
	<p if={ !opts.authed }>Please log in to view the wiki.</p>
	<div if={ !editMode && opts.authed }>
		<h2>{ this.header }</h2>
		<div class="content">{ this.content }</div>
		<p>—{ this.author }</p>
	</div>
	<form if={ editMode } onsubmit={ edit }>
		<input name="headerin" value={ this.header }>
		<br>
		<textarea name="contentin" value={ this.content }/>
		<input type="submit">
	</form>

	<div class="button" if={ opts.authed } onclick={ toggleEdit }>Edit</div>
	<div class="button" if={ opts.authed } onclick={ delete }>Delete</div>

	// logic
	var article = this
	this.editMode = false

	if (!opts.authed)
		return

	this._id = opts.article._id
	this.header = opts.article.header
	this.content = opts.article.content
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

	this.toggleEdit = function(e) {
		this.editMode = !this.editMode
	}

	// model event triggering and handling

	this.edit = function(e) {
		Wiki.trigger('article-event', {
			type: 'put',
			data: {
				header: this.headerin.value,
				content: this.contentin.value
			},
			_id: this._id
		})
	}

	Wiki.on('put-article-done', function(newArticle) {
		article.header = newArticle.header
		article.content = newArticle.content
		article.author = newArticle.author

		article.toggleEdit()
		article.update()
	})

	this.delete = function(e) {
		Wiki.trigger('article-event', {
			type: 'delete',
			_id: this._id
		})
	}

	Wiki.on('delete-article-done', function(data, id) {
		if (opts.articles)
			riot.route('articles/'+opts.articles[0]._id)
		else
			console.log("punting for now, wiki is empty")
	})
</article>