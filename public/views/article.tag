<article>
	<div if={ !editMode }>
		<h2>{ this.header }</h2>
		<div class="content">{ this.content }</div>
	</div>
	<form if={ editMode } onsubmit={ edit }>
		<input name="header" onkeyup={ input }>
		<br>
		<textarea name="content" onkeyup={ input } />
		<input type="submit">
	</form>

	<button onclick={ toggleEdit }>Edit</button>
	<button onclick={ delete }>Delete</button>

	// logic
	var article = this
	article.editMode = false

	// created from the new button
	if (opts) {
		article._id = opts._id
		article.header = opts.header
		article.content = opts.content
	}

	article.new = {}

	input(e) {
		article.new[e.target.name] = e.target.value
	}

	toggleEdit(e) {
		article.editMode = !article.editMode
	}

	edit(e) {
		$.ajax({
			type: 'PUT',
			data: {
				header: article.new.header,
				content: article.new.content
			},
			url: '/article/'+article._id
		}).done(function(newArticle) {
			article.header = newArticle.header
			article.content = newArticle.content
			article.toggleEdit(e)
			
			article.new = {}
			article.update()
		}).error(console.error)
	}

	delete(e) {
		$.ajax({
			type: 'DELETE',
			url: '/article/'+article._id
		}).done(function(res) {
			if (!res.success)
				return console.error('Failure')
			article.unmount()
		}).error(console.error)
	}
</article>