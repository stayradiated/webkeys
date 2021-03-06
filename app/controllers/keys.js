// Generated by CoffeeScript 1.4.0
(function() {
  var $, Key, KeyItem, Keys, Spine,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Spine = require('spine');

  Key = require('../models/key');

  KeyItem = require('./keys.item');

  $ = Spine.$;

  Keys = (function(_super) {

    __extends(Keys, _super);

    Keys.prototype.elements = {
      'ul.keys': 'ul',
      '.searchBox': 'searchBox'
    };

    Keys.prototype.events = {
      'keyup .searchBox': 'search'
    };

    function Keys() {
      this.addOne = __bind(this.addOne, this);

      this.refresh = __bind(this.refresh, this);

      this.filter = __bind(this.filter, this);

      this.search = __bind(this.search, this);

      this.hideSearch = __bind(this.hideSearch, this);

      this.showSearch = __bind(this.showSearch, this);
      Keys.__super__.constructor.apply(this, arguments);
      Key.bind('create', this.addOne);
      Key.bind('refresh', this.refresh);
      return;
    }

    Keys.prototype.items = [];

    Keys.prototype.searchVisible = false;

    Keys.prototype.showSearch = function() {
      var searchVisible;
      if (!!this.searchVisible) {
        return;
      }
      searchVisible = true;
      this.el.addClass('search');
      return this.searchBox.focus();
    };

    Keys.prototype.hideSearch = function() {
      var searchVisible;
      searchVisible = false;
      this.searchBox.blur();
      this.el.removeClass('search');
      this.searchBox.val('');
      return this.search();
    };

    Keys.prototype.search = function() {
      var keys, query;
      query = this.searchBox.val();
      keys = Key.filter(query);
      return this.filter(keys);
    };

    Keys.prototype.filter = function(keys) {
      var _this = this;
      this.ul.find('li').map(function(index, element) {
        var id, style;
        id = element.id.slice(4);
        style = keys.indexOf(id) < 0 ? 'none' : 'block';
        return element.style.display = style;
      });
    };

    Keys.prototype.refresh = function(keys) {
      var key, view, _i, _j, _len, _len1, _ref;
      _ref = this.items;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        view = _ref[_i];
        view.release();
      }
      this.ul.empty();
      for (_j = 0, _len1 = keys.length; _j < _len1; _j++) {
        key = keys[_j];
        view = new KeyItem({
          key: key
        });
        this.ul.prepend(view.render());
      }
    };

    Keys.prototype.addOne = function(key) {
      var element, view;
      view = new KeyItem({
        key: key
      });
      this.items.push(view);
      element = view.render();
      this.ul.prepend(element);
      key.toggleOpen(true);
      key.toggleEdit(true);
    };

    return Keys;

  })(Spine.Controller);

  module.exports = Keys;

}).call(this);
