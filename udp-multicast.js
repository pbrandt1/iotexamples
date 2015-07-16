var dgram = require('dgram');
var s = dgram.createSocket('udp4');

var multicastAddr ='239.255.0.1';

s.bind(10101, function() {
    console.log('listening for udp messages', s.address());
    console.log('subscribing to multicast on addr', multicastAddr);
    s.addMembership(multicastAddr);
});

s.on('message', function(msg, rinfo) {
    console.log(msg.length);
    console.log(msg.toString().trim(), 'from', rinfo);
});