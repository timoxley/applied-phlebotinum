(function() {
  var app, http, nko;
  http = require('http');
  nko = require('nko')('ahE2gHoOKLxdrUI0');
  app = http.createServer(function(req, res) {
    res.writeHead(200, {
      'Content-Type': 'text/html'
    });
    return res.end('Hello, World');
  });
  app.listen(parseInt(process.env.PORT) || 7777);
  console.log('Listening on ' + app.address().port);
}).call(this);
