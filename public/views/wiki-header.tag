<wiki-header>
	<button id="new-article" onclick={ toggleNew } if={ !newMode }>New Article</button>
	<form if={ newMode } onsubmit={ new }>
		<input class="text" name="header">
		<br>
		<textarea class="text" name="content"/>
		<input type="submit" value="New Article">
	</form>
	<button type="submit" onclick={ Wiki.login }>Login</button>

	// logic
	this.newMode = false

	this.toggleNew = function(e) {
		this.header.value = ''
		this.content.value = ''

		this.newMode = !this.newMode
	}

	this.new = function(e) {
		Wiki.trigger('article-event', {
			type: 'post',
			data: {
				header: this.header.value,
				content: this.content.value
			}
		})
		this.toggleNew(e)
	}
</wiki-header>