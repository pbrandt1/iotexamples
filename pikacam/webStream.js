var fs = require('fs');
var http = require('http');
var mjpeg = require('mjpeg-server');


var index = '<html><head><title>Wow stream</title></head><body>wow stream<h1>Stream</h1><image src="/stream.mjpeg"></image></body></html>';

var m = [];

http.createServer(function(req, res) {
	if (req.url.indexOf('mjpeg') < 0) {
		console.log('writing index');
		res.write(index);
		return res.end();
	}

	console.log('writing mjpeg');
    m.push(mjpeg.createReqHandler(req, res));
}).listen(8080, function() {
	console.log('listening on port 10101');
})


var dgram = require('dgram');
var s = dgram.createSocket('udp4');
var multicastAddr ='239.255.0.1';

s.bind(10101, function() {
	console.log('listening for udp messages', s.address());
	console.log('subscribing to multicast on addr', multicastAddr);
	s.addMembership(multicastAddr);
});

s.on('message', function(msg, rinfo) {
    m.map(function(m){
		m.update(msg);
	})
});