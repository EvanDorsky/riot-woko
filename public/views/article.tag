<article>
	<div if={ !editMode }>
		<h2>{ this.header }</h2>
		<div class="content">{ this.content }</div>
	</div>
	<form if={ editMode } onsubmit={ edit }>
		<input name="header" value={ this.header } onkeyup={ input }>
		<br>
		<textarea name="content" value={ this.content } onkeyup={ input }/>
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

	this.input = function(e) {
		article.new[e.target.name] = e.target.value
	}

	this.toggleEdit = function(e) {
		article.new = {
			header: article.header,
			content: article.content
		}
		
		article.editMode = !article.editMode
	}

	this.edit = function(e) {
		Wiki.trigger('update-article', article, function() {
			article.toggleEdit(e)
		})
	}

	this.delete = function(e) {
		Wiki.trigger('delete-article', article)
	}
</article>