(function() {
	var xhr = new XMLHttpRequest();
	var params = 'url=' + window.location.href;
	xhr.open('POST', 'http://localhost:9292/clips', true);
	xhr.onreadystatechange = function() {
		if (this.readyState == 4) {
			if (xhr.status == 200) {
				if (xhr.responseText.success) {
					// window.alert('Clipped');
				}
			}
		}
	};
	xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xhr.send(params);
})()