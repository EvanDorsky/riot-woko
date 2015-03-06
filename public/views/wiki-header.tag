<wiki-header>
	<nav class="light-blue">
		<div class="nav-wrapper container">
			<span class="brand-logo">Olin Wiki</span>
			<ul class="right">
			<li>
				<a href="#" onclick={ toggleNew }>New Article</a>
			</li>
			</ul>
			<form if={ newMode } onsubmit={ new }>
				<input class="text" name="header">
				<br>
				<textarea class="text" name="content"/>
				<input type="submit" value="New Article" class="btn">
			</form>
		</div>
	</nav>

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