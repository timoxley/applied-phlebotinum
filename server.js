(function() {
  var app, express, fs, http, nib, nko, path, stylus;
  http = require('http');
  nko = require('nko')('ahE2gHoOKLxdrUI0');
  express = require('express');
  fs = require('fs');
  path = require('path');
  stylus = require('stylus');
  nib = require('nib');
  app = express.createServer();
  app.configure(function() {
    app.use(express.bodyParser());
    app.use(express.cookieParser());
    app.use(stylus.middleware({
      src: "" + __dirname + "/app/views",
      dest: "" + __dirname + "/public",
      force: true,
      compile: function(str, path) {
        return stylus(str).set('filename', path).set('compress', false).set('warn', true).use(nib());
      }
    }));
    app.set('views', "" + __dirname + "/app/views");
    app.set('view engine', 'jade');
    app.get('/', function(req, res) {
      var options;
      options = {};
      options.locals = {
        project: "Applied Phlebotinum",
        page_title: "Home"
      };
      return res.render('index', options);
    });
    app.use(express.logger());
    return app.use(express.static("" + __dirname + "/public"));
  });
  app.listen(parseInt(process.env.PORT) || 7777);
  console.log('Listening on ' + app.address().port);
}).call(this);
