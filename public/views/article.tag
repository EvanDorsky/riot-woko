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
	this.editMode = false

	this._id = opts.article._id
	this.header = opts.article.header
	this.content = opts.article.content

	this.new = {}

	this.input = function(e) {
		this.new[e.target.name] = e.target.value
	}

	this.toggleEdit = function(e) {
		this.new = {
			header: this.header,
			content: this.content
		}
		
		this.editMode = !this.editMode
	}

	this.edit = function(e) {
		var that = this
		Wiki.trigger('update-article', this, function() {
			that.toggleEdit(e)
		})
	}

	this.delete = function(e) {
		Wiki.trigger('delete-article', this)
	}
</article>