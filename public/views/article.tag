<article>
	<div if={ !editMode }>
		<h2>{ this.header }</h2>
		<div class="content">{ this.content }</div>
	</div>
	<form if={ editMode } onsubmit={ edit }>
		<input name="header" onkeyup={ input }>
		<input name="content" onkeyup={ input }>
		<input type="submit">
	</form>

	<button onclick={ toggleEdit }>Edit</button>

	// logic
	var article = this
	this.editMode = false

	// created from the new button
	if (opts) {
		this.header = opts.header
		this.content = opts.content
	}

	article.new = {}

	input(e) {
		article.new[e.target.name] = e.target.value
	}

	toggleEdit(e) {
		this.editMode = !this.editMode
	}

	edit(e) {
		console.log("bodget")
		$.ajax({
			type: 'PUT',
			data: {
				_id: article._id,
				header: article.new.header,
				content: article.new.content
			},
			url: '/article'
		}).done(function(newArticle) {
			article.header = newArticle.header
			article.content = newArticle.content
			article.toggleEdit(e)
			article.update()
		}).error(console.error)
	}
</article>