var mdns = require('mdns-js');
var browser = mdns.createBrowser();

browser.on('ready', function () {
    browser.discover();
});

browser.on('update', function (data) {
    console.log('data:', data);
});
