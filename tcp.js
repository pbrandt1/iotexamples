var net = require('net');
var twitter = require('./twitter');

var server = net.createServer(function(socket) {
    socket.write('Welcome to @peterbot11\'s twitter search socket\n');
    socket.write('Please enter a search term: ');
    socket.on('data', function(data) {
        twitter.streamSearch(data).pipe(socket);
    });
});
server.listen(10101);