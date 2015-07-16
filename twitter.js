var Twitter = require('twitter');
var Readable = require('stream').Readable;

var client = new Twitter({

});

module.exports.streamSearch = function(searchTerm) {
    var newStream = new Readable();
    newStream._read = function() {};

    client.stream('statuses/filter', {track: searchTerm}, function(stream) {
        stream.on('data', function(tweet) {
            var text = '[' + tweet.user.name + ' @' + tweet.user.screen_name + '] ' + tweet.text + '\n\n';
            console.log(text);
            newStream.push(text);
        });
    });

    return newStream;
};