var app = require('./controller/App.js');

var port = 8081;


var server = app.listen(port, function(){
    console.log('BackEnd  Hosted at http://localhost:%s', port);
});