
(function(/*! Stitch !*/) {
  if (!this.require) {
    var modules = {}, cache = {}, require = function(name, root) {
      var module = cache[name], path = expand(root, name), fn;
      if (module) {
        return module;
      } else if (fn = modules[path] || modules[path = expand(path, './index')]) {
        module = {id: name, exports: {}};
        try {
          cache[name] = module.exports;
          fn(module.exports, function(name) {
            return require(name, dirname(path));
          }, module);
          return cache[name] = module.exports;
        } catch (err) {
          delete cache[name];
          throw err;
        }
      } else {
        throw 'module \'' + name + '\' not found';
      }
    }, expand = function(root, name) {
      var results = [], parts, part;
      if (/^\.\.?(\/|$)/.test(name)) {
        parts = [root, name].join('/').split('/');
      } else {
        parts = name.split('/');
      }
      for (var i = 0, length = parts.length; i < length; i++) {
        part = parts[i];
        if (part == '..') {
          results.pop();
        } else if (part != '.' && part != '') {
          results.push(part);
        }
      }
      return results.join('/');
    }, dirname = function(path) {
      return path.split('/').slice(0, -1).join('/');
    };
    this.require = function(name) {
      return require(name, '');
    }
    this.require.define = function(bundle) {
      for (var key in bundle)
        modules[key] = bundle[key];
    };
  }
  return this.require.define;
}).call(this)({"app": function(exports, require, module) {(function() {
  var Avatar, World, WorldView;
  World = require('./models/world').World;
  WorldView = require('./views/worldview').WorldView;
  Avatar = require('./models/avatar').Avatar;
  module.exports = {
    init: function() {
      this.world = new World();
      console.log(this.world);
      this.worldView = new WorldView(this.world, '#world');
      this.world.addAvatar(new Avatar('test 1'));
      this.world.addAvatar(new Avatar('test 2'));
      return this.world.addAvatar(new Avatar('test 3'));
    }
  };
}).call(this);
}, "models/avatar": function(exports, require, module) {(function() {
  var Avatar, EventEmitter2;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  EventEmitter2 = require('eventemitter2').EventEmitter2;
  Avatar = (function() {
    __extends(Avatar, EventEmitter2);
    function Avatar(name) {
      this.name = name;
      console.log("Avatar Created: " + name);
      this.x = Math.random() * 200;
      this.y = Math.random() * 200;
    }
    return Avatar;
  })();
  module.exports = {
    Avatar: Avatar
  };
}).call(this);
}, "models/world": function(exports, require, module) {(function() {
  var EventEmitter2, World;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  EventEmitter2 = require('eventemitter2').EventEmitter2;
  World = (function() {
    __extends(World, EventEmitter2);
    function World() {
      this.addAvatar = __bind(this.addAvatar, this);      console.log("World Created");
      this.avatars = [];
    }
    World.prototype.addAvatar = function(avatar) {
      this.avatars.push(avatar);
      return this.emit('avatar.added', avatar);
    };
    return World;
  })();
  module.exports = {
    World: World
  };
}).call(this);
}, "views/avatarview": function(exports, require, module) {(function() {
  var AvatarView;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  AvatarView = (function() {
    function AvatarView(avatar) {
      this.avatar = avatar;
      this.render = __bind(this.render, this);
      console.log("new avatar view");
    }
    AvatarView.prototype.render = function(canvas) {
      canvas.addChild(canvas.display.rectangle({
        x: this.avatar.x,
        y: this.avatar.y,
        width: 10,
        height: 10,
        fill: "#333"
      }));
      console.log("rendering avatar: ");
      console.log(this.avatar.name);
      console.log(this.avatar.x);
      return console.log(this.avatar.y);
    };
    return AvatarView;
  })();
  module.exports = {
    AvatarView: AvatarView
  };
}).call(this);
}, "views/worldview": function(exports, require, module) {(function() {
  var AvatarView, WorldView;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  AvatarView = require('./avatarview').AvatarView;
  WorldView = (function() {
    function WorldView(world, el) {
      this.world = world;
      this.el = el;
      this.addAvatarView = __bind(this.addAvatarView, this);
      console.log("WorldView Created for world:");
      console.log(this.world);
      this.avatarViews = [];
      this.canvas = oCanvas.create({
        canvas: this.el
      });
      this.canvas.width = 600;
      this.canvas.height = 600;
      this.world.on('avatar.added', __bind(function(avatar) {
        return this.addAvatarView(new AvatarView(avatar));
      }, this));
    }
    WorldView.prototype.addAvatarView = function(avatarView) {
      this.avatarViews.push(avatarView);
      return avatarView.render(this.canvas);
    };
    return WorldView;
  })();
  module.exports = {
    WorldView: WorldView
  };
}).call(this);
}, "eventemitter2": function(exports, require, module) {
;!function(exports, undefined) {

  var isArray = Array.isArray;
  var defaultMaxListeners = 10;

  function init() {
    this._events = new Object;
  }

  function configure(conf) {

    if (conf) {
      this.wildcard = conf.wildcard;
      this.delimiter = conf.delimiter || '.';

      if (this.wildcard) {
        this.listenerTree = new Object;
      }
    }
  }

  function EventEmitter(conf) {
    this._events = new Object;
    configure.call(this, conf);
  }

  function searchListenerTree(handlers, type, tree, i) {
    if (!tree) {
      return;
    }

    var listeners;

    if (i === type.length && tree._listeners) {
      //
      // If at the end of the event(s) list and the tree has listeners
      // invoke those listeners.
      //
      if (typeof tree._listeners === 'function') {
        handlers && handlers.push(tree._listeners);
        return tree;
      } else {
        for (var leaf = 0, len = tree._listeners.length; leaf < len; leaf++) {
          handlers && handlers.push(tree._listeners[leaf]);
        }
        return tree;
      }
    }

    if (type[i] === '*' || tree[type[i]]) {
      //
      // If the event emitted is '*' at this part
      // or there is a concrete match at this patch
      //
      if (type[i] === '*') {
        for (var branch in tree) {
          if (branch !== '_listeners' && tree.hasOwnProperty(branch)) {
            listeners = searchListenerTree(handlers, type, tree[branch], i+1);
          }
        }
        return listeners;
      }

      listeners = searchListenerTree(handlers, type, tree[type[i]], i+1);
    }


    if (tree['*']) {
      //
      // If the listener tree will allow any match for this part,
      // then recursively explore all branches of the tree
      //
      searchListenerTree(handlers, type, tree['*'], i+1);
    }

    return listeners;
  };

  function growListenerTree(type, listener) {

    type = typeof type === 'string' ? type.split(this.delimiter) : type.slice();

    var tree = this.listenerTree;
    var name = type.shift();

    while (name) {

      if (!tree[name]) {
        tree[name] = new Object;
      }

      tree = tree[name];

      if (type.length === 0) {

        if (!tree._listeners) {
          tree._listeners = listener;
        }
        else if(typeof tree._listeners === 'function') {
          tree._listeners = [tree._listeners, listener];
        }
        else if (isArray(tree._listeners)) {

          tree._listeners.push(listener);

          if (!tree._listeners.warned) {

            var m = defaultMaxListeners;

            if (m > 0 && tree._listeners.length > m) {

              tree._listeners.warned = true;
              console.error('(node) warning: possible EventEmitter memory ' +
                            'leak detected. %d listeners added. ' +
                            'Use emitter.setMaxListeners() to increase limit.',
                            tree._listeners.length);
              console.trace();
            }
          }
        }
        return true;
      }
      name = type.shift();
    }
    return true;
  };

  // By default EventEmitters will print a warning if more than
  // 10 listeners are added to it. This is a useful default which
  // helps finding memory leaks.
  //
  // Obviously not all Emitters should be limited to 10. This function allows
  // that to be increased. Set to zero for unlimited.

  EventEmitter.prototype.setMaxListeners = function(n) {
    this._events || init.call(this);
    this._events.maxListeners = n;
  };

  EventEmitter.prototype.event = '';

  EventEmitter.prototype.once = function(event, fn) {
    this.many(event, 1, fn);
    return this;
  };

  EventEmitter.prototype.many = function(event, ttl, fn) {
    var self = this;

    if (typeof fn !== 'function') {
      throw new Error('many only accepts instances of Function');
    }

    function listener() {
      if (--ttl === 0) {
        self.off(event, listener);
      }
      fn.apply(null, arguments);
    };

    listener._origin = fn;

    this.on(event, listener);

    return self;
  };

  EventEmitter.prototype.emit = function() {
    this._events || init.call(this);

    var type = arguments[0];

    if (type === 'newListener') {
      if (!this._events.newListener) { return false; }
    }

    // Loop through the *_all* functions and invoke them.
    if (this._all) {
      var l = arguments.length;
      var args = new Array(l - 1);
      for (var i = 1; i < l; i++) args[i - 1] = arguments[i];
      for (i = 0, l = this._all.length; i < l; i++) {
        this.event = type;
        this._all[i].apply(this, args);
      }
    }

    // If there is no 'error' event listener then throw.
    if (type === 'error') {
      
      if (!this._all && 
        !this._events.error && 
        !(this.wildcard && this.listenerTree.error)) {

        if (arguments[1] instanceof Error) {
          throw arguments[1]; // Unhandled 'error' event
        } else {
          throw new Error("Uncaught, unspecified 'error' event.");
        }
        return false;
      }
    }

    var handler;

    if(this.wildcard) {
      handler = [];
      var ns = typeof type === 'string' ? type.split(this.delimiter) : type.slice();
      searchListenerTree.call(this, handler, ns, this.listenerTree, 0);
    }
    else {
      handler = this._events[type];
    }

    if (typeof handler === 'function') {
      this.event = type;
      if (arguments.length === 1) {
        handler.call(this);
      }
      else if (arguments.length > 1)
        switch (arguments.length) {
          case 2:
            handler.call(this, arguments[1]);
            break;
          case 3:
            handler.call(this, arguments[1], arguments[2]);
            break;
          // slower
          default:
            var l = arguments.length;
            var args = new Array(l - 1);
            for (var i = 1; i < l; i++) args[i - 1] = arguments[i];
            handler.apply(this, args);
        }
      return true;
    }
    else if (handler) {
      var l = arguments.length;
      var args = new Array(l - 1);
      for (var i = 1; i < l; i++) args[i - 1] = arguments[i];

      var listeners = handler.slice();
      for (var i = 0, l = listeners.length; i < l; i++) {
        this.event = type;
        listeners[i].apply(this, args);
      }
      return true;
    }

  };

  EventEmitter.prototype.on = function(type, listener) {
    this._events || init.call(this);

    // To avoid recursion in the case that type == "newListeners"! Before
    // adding it to the listeners, first emit "newListeners".
    this.emit('newListener', type, listener);

    if(this.wildcard) {
      growListenerTree.call(this, type, listener);
      return this;
    }

    if (!this._events[type]) {
      // Optimize the case of one listener. Don't need the extra array object.
      this._events[type] = listener;
    }
    else if(typeof this._events[type] === 'function') {
      // Adding the second element, need to change to array.
      this._events[type] = [this._events[type], listener];
    }
    else if (isArray(this._events[type])) {
      // If we've already got an array, just append.
      this._events[type].push(listener);

      // Check for listener leak
      if (!this._events[type].warned) {

        var m;
        if (this._events.maxListeners !== undefined) {
          m = this._events.maxListeners;
        } else {
          m = defaultMaxListeners;
        }

        if (m && m > 0 && this._events[type].length > m) {

          this._events[type].warned = true;
          console.error('(node) warning: possible EventEmitter memory ' +
                        'leak detected. %d listeners added. ' +
                        'Use emitter.setMaxListeners() to increase limit.',
                        this._events[type].length);
          console.trace();
        }
      }
    }
    return this;
  };

  EventEmitter.prototype.onAny = function(fn) {

    if(!this._all) {
      this._all = [];
    }

    if (typeof fn !== 'function') {
      throw new Error('onAny only accepts instances of Function');
    }

    // Add the function to the event listener collection.
    this._all.push(fn);
    return this;
  };

  EventEmitter.prototype.addListener = EventEmitter.prototype.on;

  EventEmitter.prototype.off = function(type, listener) {
    if (typeof listener !== 'function') {
      throw new Error('removeListener only takes instances of Function');
    }

    var handlers;

    if(this.wildcard) {
      var ns = typeof type === 'string' ? type.split(this.delimiter) : type.slice();
      var leaf = searchListenerTree.call(this, null, ns, this.listenerTree, 0);

      if('undefined' === typeof leaf) { return this; }
      handlers = leaf._listeners;
    }
    else {
      // does not use listeners(), so no side effect of creating _events[type]
      if (!this._events[type]) return this;
      handlers = this._events[type];
    }

    if (isArray(handlers)) {

      var position = -1;

      for (var i = 0, length = handlers.length; i < length; i++) {
        if (handlers[i] === listener ||
          (handlers[i].listener && handlers[i].listener === listener) ||
          (handlers[i]._origin && handlers[i]._origin === listener)) {
          position = i;
          break;
        }
      }

      if (position < 0) {
        return this;
      }

      if(this.wildcard) {
        leaf._listeners.splice(position, 1)
      }
      else {
        this._events[type].splice(position, 1);
      }

      if (handlers.length === 0) {
        if(this.wildcard) {
          delete leaf._listeners;
        }
        else {
          delete this._events[type];
        }
      }
    }
    else if (handlers === listener ||
      (handlers.listener && handlers.listener === listener) ||
      (handlers._origin && handlers._origin === listener)) {
      if(this.wildcard) {
        delete leaf._listeners;
      }
      else {
        delete this._events[type];
      }
    }

    return this;
  };

  EventEmitter.prototype.offAny = function(fn) {
    var i = 0, l = 0, fns;
    if (fn && this._all && this._all.length > 0) {
      fns = this._all;
      for(i = 0, l = fns.length; i < l; i++) {
        if(fn === fns[i]) {
          fns.splice(i, 1);
          return this;
        }
      }
    } else {
      this._all = [];
    }
    return this;
  };

  EventEmitter.prototype.removeListener = EventEmitter.prototype.off;

  EventEmitter.prototype.removeAllListeners = function(type) {
    if (arguments.length === 0) {
      !this._events || init.call(this);
      return this;
    }

    if(this.wildcard) {
      var ns = typeof type === 'string' ? type.split(this.delimiter) : type.slice();
      var leaf = searchListenerTree.call(this, null, ns, this.listenerTree, 0);

      if('undefined' === typeof leaf) { return this; }
      leaf._listeners = null;
    }
    else {
      if (!this._events[type]) return this;
      this._events[type] = null;
    }
    return this;
  };

  EventEmitter.prototype.listeners = function(type) {
    if(this.wildcard) {
      var handlers = [];
      var ns = typeof type === 'string' ? type.split(this.delimiter) : type.slice();
      searchListenerTree.call(this, handlers, ns, this.listenerTree, 0);
      return handlers;
    }

    this._events || init.call(this);

    if (!this._events[type]) this._events[type] = [];
    if (!isArray(this._events[type])) {
      this._events[type] = [this._events[type]];
    }
    return this._events[type];
  };

  EventEmitter.prototype.listenersAny = function() {

    if(this._all) {
      return this._all;
    }
    else {
      return [];
    }

  };

  exports.EventEmitter2 = EventEmitter;

}(typeof exports === 'undefined' ? window : exports);
}});
