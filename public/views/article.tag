<article>
	<h2>{ this.header }</h2>

	<div class="content">{ this.content }</div>

	<button onclick={ edit }>Edit</button>

	// logic

	this.header = "Dorem sispum"
	this.content = "Lorem ipsum"
	this.id = 1
	
	edit(e) {
		$.ajax({
			type: 'PUT',
			data: {
				header: 'new',
				content: 'now'
			},
			url: '/article'
		}).done(function(data) {
			alert(data.gotit);
		});
	}
</article>