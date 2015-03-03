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

	<button onclick={ edit }>Edit</button>

	// logic
	var article = this

	// created from the new button
	if (opts) {
		this.header = opts.header
		this.content = opts.content
	}

	edit(e) {
		$.ajax({
			type: 'PUT',
			data: {
				_id: article._id,
				header: 'bogooooo',
				content: 'dsafsdfa'
			},
			url: '/article'
		}).done(function(newArticle) {
			article.header = newArticle.header
			article.content = newArticle.content
			article.update()
		});
	}
</article>