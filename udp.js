var dgram = require('dgram');
var s = dgram.createSocket('udp4');

s.bind(10101, function() {
    console.log('listening for udp messages', s.address());
});

s.on('message', function(msg, rinfo) {
    console.log(msg.toString());
    s.send(msg, 0, msg.length, rinfo.port, rinfo.address);
});