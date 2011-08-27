(function() {
  var Client, EventEmitter2;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  EventEmitter2 = require('eventemitter2').EventEmitter2;
  Client = (function() {
    __extends(Client, EventEmitter2);
    function Client() {}
    return Client;
  })();
  module.exports = {
    Client: Client
  };
}).call(this);
