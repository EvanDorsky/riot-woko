<article>
	<form onsubmit={ submit }>
		<input name="header">{ this.header || '' }</input>

		<form name="content">{ this.content || '' }</input>

		<input type="submit">Done</input>
	</form>

	// logic

	this.header = "Dorem sispum"
	this.content = "Lorem ipsum"
	this.id = 1
	
	submit(e) {
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