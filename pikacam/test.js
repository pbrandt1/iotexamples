var pikacam = require('./');

pikacam.onData(function(buff) {
	console.log(buff, buff.length);
});
