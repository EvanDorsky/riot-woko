<wiki-header>
	<button id="new-article" onclick={ toggleNew } if={ !Wiki.newMode && opts.authed }>New Article</button>
	<button if={ !opts.authed } onclick={ Wiki.login }>Login</button>
	<button if={ opts.authed } onclick={ Wiki.logout }>Logout</button>

	// logic
	var header = this

	this.toggleNew = function(e) {
		Wiki.newMode = !Wiki.newMode
		Wiki.trigger('post-article-init')
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