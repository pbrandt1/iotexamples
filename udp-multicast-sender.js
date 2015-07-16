var dgram = require('dgram');
var s = dgram.createSocket('udp4');

var multicastAddr ='239.255.0.1';

s.bind(10101, function() {
    console.log('posting to multicast on addr', multicastAddr);
    var i = 110;
    setInterval(function() {
        var message = new Buffer("my blood pressure is " + i++);
        s.send(message, 0, message.length, 10101, multicastAddr, function() {
            console.log(message.toString());
        });
    }, 1000);
});
