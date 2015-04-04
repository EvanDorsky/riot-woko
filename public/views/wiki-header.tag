<wiki-header>
	<button id="new-article" onclick={ toggleNew } if={ !newMode && opts.authed }>New Article</button>
	<button if={ !opts.authed } onclick={ Wiki.login }>Login</button>
	<button if={ opts.authed } onclick={ Wiki.logout }>Logout</button>
  <button if={ opts.authed && (!Wiki.editMode && !Wiki.newMode) } onclick={ toggleEdit }>Edit</button>
  <button if={ opts.authed && (!Wiki.editMode && !Wiki.newMode) } onclick={ delete }>Delete</button>

	// logic
	var header = this

  this.toggleEdit = function(e) {
    Wiki.trigger('toggle-edit')
  }

	this.toggleNew = function(e) {
    Wiki.trigger('toggle-new')
		Wiki.trigger('post-article-init')
	}

  this.delete = function(e) {
    Wiki.trigger('delete-article-init')
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