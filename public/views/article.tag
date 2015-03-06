<article>
	<div if={ !editMode }>
		<button onclick={ toggleEdit } class="btn light-blue waves-effect waves-light">Edit</button>
		<button onclick={ delete } class="btn light-blue waves-effect waves-light">Delete</button>
		<h2>{ this.header }</h2>
		<div class="content">{ this.content }</div>
	</div>
	<form if={ editMode } onsubmit={ edit }>
		<input name="headerin" value={ this.header }>
		<br>
		<textarea name="contentin" value={ this.content }/>
		<button type="submit" class="btn light-blue waves-effect waves-light">Submit</button>
	</form>

	// logic
	var article = this
	this.editMode = false

	this._id = opts.article._id
	this.header = opts.article.header
	this.content = opts.article.content

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