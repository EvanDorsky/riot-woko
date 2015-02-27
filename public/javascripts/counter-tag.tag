<counter>
	<h1>Hello world!</h1>

	<button onclick={ increment }>{ this.number }</button>

	<script>
		this.number = 0;
		
		increment(e) {
			this.number++;
		}
	</script>
</counter>