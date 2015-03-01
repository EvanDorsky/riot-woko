<articles>

	<button onclick={ new }>New Article</button>

	<article each={ opts.articles }/>

	new(e) {
		$.ajax({
			type: 'POST',
			data: {
				header: 'New article',
				content: 'This content'
			},
			url: '/article'
		}).done(function(data) {
			console.log(data.success)
		})
	}
</articles>