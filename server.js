var fs = require('fs'),
    CoffeeScript = require('coffee-script')

require.extensions['.js.coffee'] = function(module, filename) {
  content = CoffeeScript.compile(fs.readFileSync(filename), 'utf8');
  module._compile(content, filename);
}

require('./src/server');