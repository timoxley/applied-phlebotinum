(function() {
  var app, coffee, directoryExists, express, fs, http, nib, nko, package, path, stitch, stylus;
  http = require('http');
  nko = require('nko')('ahE2gHoOKLxdrUI0');
  stitch = require('stitch');
  coffee = require('coffee-script');
  express = require('express');
  fs = require('fs');
  path = require('path');
  stylus = require('stylus');
  nib = require('nib');
  directoryExists = function(dir) {
    try {
      fs.statSync(dir);
      return true;
    } catch (err) {
      return false;
    }
  };
  package = stitch.createPackage({
    paths: ["" + __dirname + "/client/app", "" + __dirname + "/client/app/", path.resolve(require.resolve('eventemitter2'), '..')]
  });
  package.compile(function(err, source) {
    var destDir;
    destDir = "" + __dirname + "/public/scripts/";
    if (!directoryExists(destDir)) {
      fs.mkdirSync(destDir, 0775);
    }
    return fs.writeFile("" + __dirname + "/public/scripts/application.js", source, function(err) {
      if (err) {
        throw err;
      }
      return console.log('Compiled application.js');
    });
  });
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
    app.get('/test', function(req, res) {
      var options;
      options = {};
      return res.send("" + __dirname + "/client/app");
    });
    app.use(express.logger());
    return app.use(express.static("" + __dirname + "/public"));
  });
  app.listen(parseInt(process.env.PORT) || 7777);
  console.log('Listening on ' + app.address().port);
}).call(this);
