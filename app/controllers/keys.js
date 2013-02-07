// Generated by CoffeeScript 1.4.0
(function() {
  var $, Key, KeyItem, Keys, Spine,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Spine = require('../libs/spine');

  Key = require('../models/key');

  KeyItem = require('./keys.item');

  $ = Spine.$;

  Keys = (function(_super) {

    __extends(Keys, _super);

    function Keys() {
      this.addOne = __bind(this.addOne, this);

      this.refresh = __bind(this.refresh, this);
      Keys.__super__.constructor.apply(this, arguments);
      Key.bind('create', this.addOne);
    }

    Keys.prototype.refresh = function(keys) {
      var key, view, _i, _len, _results;
      this.el.empty();
      _results = [];
      for (_i = 0, _len = keys.length; _i < _len; _i++) {
        key = keys[_i];
        view = new KeyItem({
          key: key
        });
        _results.push(this.el.prepend(view.render()));
      }
      return _results;
    };

    Keys.prototype.addOne = function(key) {
      var element, view;
      view = new KeyItem({
        key: key
      });
      element = view.render();
      element.addClass('new');
      this.el.prepend(element);
      return setTimeout(function() {
        return element.removeClass('new');
      }, 1);
    };

    return Keys;

  })(Spine.Controller);

  module.exports = Keys;

}).call(this);
