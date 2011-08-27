(function() {
  var app, appDir, coffee, common, directoryExists, express, fs, http, nib, nko, package, path, stitch, stylus, winston;
  http = require('http');
  nko = require('nko')('ahE2gHoOKLxdrUI0');
  coffee = require('coffee-script');
  common = require('./common');
  winston = common.winston;
  appDir = common.appDir;
  stitch = require('stitch');
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
    paths: ["" + appDir + "/client/app", "" + appDir + "/client/app/", path.resolve(require.resolve('eventemitter2'), '..')]
  });
  package.compile(function(err, source) {
    var destDir;
    destDir = "" + appDir + "/public/scripts/";
    if (!directoryExists(destDir)) {
      fs.mkdirSync(destDir, 0775);
    }
    return fs.writeFile("" + appDir + "/public/scripts/application.js", source, function(err) {
      if (err) {
        throw err;
      }
      return winston.info('Compiled application.js');
    });
  });
  app = express.createServer();
  app.configure(function() {
    app.use(express.bodyParser());
    app.use(express.cookieParser());
    app.use(stylus.middleware({
      src: "" + appDir + "/app/views",
      dest: "" + appDir + "/public",
      force: true,
      compile: function(str, path) {
        return stylus(str).set('filename', path).set('compress', false).set('warn', true).use(nib());
      }
    }));
    app.set('views', "" + appDir + "/app/views");
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
      return res.send("" + appDir + "/client/app");
    });
    app.use(express.logger());
    return app.use(express.static("" + appDir + "/public"));
  });
  app.listen(parseInt(process.env.PORT) || 7777);
  winston.info('Listening on ' + app.address().port);
}).call(this);
