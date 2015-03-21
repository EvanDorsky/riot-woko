<article>
	<p if={ !opts.authed }>Please log in to view the wiki.</p>
	<div if={ (!editMode && !Wiki.newMode ) && opts.authed }>
		<h2>{ this.header }</h2>
		<div class="content">{ this.content }</div>
		<p>—{ this.author }</p>
	</div>
	<form if={ editMode || Wiki.newMode }>
		<input name="headerin">
		<br>
		<textarea name="contentin"/>
		<button onclick={ submit }>Submit</button>
		<button onclick={ cancel }>Cancel</button>
	</form>

	<div class="edit-buttons" if={ !editMode && !Wiki.newMode }>
		<div class="button" if={ opts.authed } onclick={ toggleEdit }>Edit</div>
		<div class="button" if={ opts.authed } onclick={ delete }>Delete</div>
	</div>

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
		this.headerin.value = this.header
		this.contentin.value = this.content

		this.editMode = !this.editMode
	}

	this.cancel = function(e) {
		if (!Wiki.newMode)
			return article.toggleEdit()
		else
			Wiki.newMode = !Wiki.newMode
		riot.update()
	}

	// model event triggering and handling

	Wiki.on('post-article-init', function() {
		article.headerin.value = ''
		article.contentin.value = ''

		article.update()
	})

	Wiki.on('post-article-done', function(newArticle) {
		Wiki.newMode = !Wiki.newMode
		article.update()
	})

	this.submit = function(e) {
		Wiki.trigger('article-event', {
			type: Wiki.newMode? 'post' : 'put',
			data: {
				header: this.headerin.value,
				content: this.contentin.value
			},
			_id: Wiki.newMode? null : this._id
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