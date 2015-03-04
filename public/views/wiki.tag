window.Wiki = riot.observable();

<wiki>
	<form id="new-article" onsubmit={ new }>
		<input class="text" name="header" onkeyup={ input }>
		<br>
		<textarea class="text" name="content" onkeyup={ input }/>
		<input type="submit" value="New Article">
	</form>

	<div id="article-list">
		<li each={ opts.articles }>
			<h2 onclick={ parent.showArticle }>{ header }</h2>
			<p>{ content }<p>
		</li>
	</div>

	// logic
	var articleList = this

	articleList.new = {}

	this.input = function(e) {
		articleList.new[e.target.name] = e.target.value
	}

	function byId(id) {
		return opts.articles.find(function(art) {
			return art._id == id
		})
	}

	riot.route(function(collection, id, action) {
		if (!action) {// show
			var article = byId(id)
			console.log("article")
			console.log(article)
		}
	})

	this.showArticle = function(e) {
		riot.route('articles/'+e.item._id)
	}

	Wiki.on('delete-article', function (article) {
		$.ajax({
			type: 'DELETE',
			url: '/article/'+article._id
		}).done(function(res) {
			if (!res.success)
				return console.error('Failure')

			var toRemove = byId(article._id)

			opts.articles.splice(opts.articles.indexOf(toRemove), 1)

			articleList.update()
		}).error(console.error)
	})

	Wiki.on('update-article', function(article, callback) {
		console.log("UPDATE ARTICLE")
		$.ajax({
			type: 'PUT',
			data: article.new,
			url: '/article/'+article._id
		}).done(function(newArticle) {
			var toUpdate = byId(article._id)

			toUpdate.header = newArticle.header
			toUpdate.content = newArticle.content

			callback()
			
			articleList.update()
		}).error(console.error)
	})

	new(e) {
		$.ajax({
			type: 'POST',
			data: articleList.new,
			url: '/article'
		}).done(function(article) {
			opts.articles.unshift(article)

			$('#new-article .text').val('')
			articleList.update()
		}).error(console.error)
	}
</wiki>