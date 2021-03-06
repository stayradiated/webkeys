// Generated by CoffeeScript 1.4.0
(function() {
  var $, KeyItem, Spine, clipboard,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Spine = require('spine');

  $ = Spine.$;

  clipboard = gui.Clipboard.get();

  KeyItem = (function(_super) {

    __extends(KeyItem, _super);

    KeyItem.prototype.tag = 'li';

    KeyItem.prototype.selectors = {
      '.title': 'title',
      '.username': 'username',
      '.url': 'url'
    };

    KeyItem.prototype.events = {
      'click .arrow-down': 'toggleOpen',
      'click button.edit': 'toggleEdit',
      'click .username': 'copyUsername',
      'click .password': 'copyPassword',
      'focus input': 'focusInput',
      'blur input': 'blurInput'
    };

    function KeyItem() {
      this.blurInput = __bind(this.blurInput, this);

      this.focusInput = __bind(this.focusInput, this);

      this.copyPassword = __bind(this.copyPassword, this);

      this.copyUsername = __bind(this.copyUsername, this);

      this.save = __bind(this.save, this);

      this.edit = __bind(this.edit, this);

      this.close = __bind(this.close, this);

      this.open = __bind(this.open, this);

      this.deselect = __bind(this.deselect, this);

      this.select = __bind(this.select, this);

      this.render = __bind(this.render, this);

      this.update = __bind(this.update, this);

      this.bindSelectors = __bind(this.bindSelectors, this);

      this.toggleEdit = __bind(this.toggleEdit, this);

      this.toggleOpen = __bind(this.toggleOpen, this);

      this.click = __bind(this.click, this);
      KeyItem.__super__.constructor.apply(this, arguments);
      this.key.bind('select', this.select);
      this.key.bind('deselect', this.deselect);
      this.key.bind('open', this.open);
      this.key.bind('close', this.close);
      this.key.bind('open-edit', this.edit);
      this.key.bind('close-edit', this.save);
      this.key.bind('update', this.update);
      this.el.attr('id', "key-" + this.key.id);
    }

    KeyItem.prototype.click = function(event) {
      return this.key.select();
    };

    KeyItem.prototype.toggleOpen = function(event) {
      return this.key.toggleOpen();
    };

    KeyItem.prototype.toggleEdit = function(event) {
      return this.key.toggleEdit();
    };

    KeyItem.prototype.bindSelectors = function() {
      var name, selector, _ref, _results;
      _ref = this.selectors;
      _results = [];
      for (selector in _ref) {
        name = _ref[selector];
        _results.push(this["el_" + name] = this.el.find(selector));
      }
      return _results;
    };

    KeyItem.prototype.update = function() {
      this.el_title.html(this.key.title);
      this.el_username.html(this.key.username);
      return this.el_url.html(this.key.url);
    };

    KeyItem.prototype.render = function() {
      var template;
      template = "<div class=\"main\">\n  <div class=\"button arrow-down\"></div>\n  <img src=\"icons/" + this.key.icon + ".png\" width=\"32\" height=\"32\">\n  <h3 class=\"title\">" + this.key.title + "</h3>\n  <p class=\"username\">" + this.key.username + "</p>\n</div>";
      this.el.html($(template));
      this.bindSelectors();
      return this.el;
    };

    KeyItem.prototype.select = function() {
      return this.el.addClass('active');
    };

    KeyItem.prototype.deselect = function() {
      return this.el.removeClass('active');
    };

    KeyItem.prototype.open = function() {
      var template;
      template = "<div class=\"dropdown\">\n  <div class=\"details-pane\">\n    <div class=\"control\">\n      <label>URL:</label>\n      <div class=\"url\">" + this.key.url + "</div>\n    </div>\n    <div class=\"control\">\n      <label>Username:</label>\n      <div class=\"username copy\">" + this.key.username + "</div>\n    </div>\n    <div class=\"control\">\n      <label>Password:</label>\n      <div class=\"password copy\">••••••••••</div>\n    </div>\n    <button class=\"edit\">Edit</button>\n  </div>\n  <div class=\"edit-pane\">\n    <div class=\"control\">\n      <label>Title:</label>\n      <input class=\"title\" type=\"text\" value=\"" + this.key.title + "\">\n    </div>\n    <div class=\"control\">\n      <label>URL:</label>\n      <input class=\"url\" type=\"text\" value=\"" + this.key.url + "\">\n    </div>\n    <div class=\"control\">\n      <label>Username:</label>\n      <input class=\"username\" type=\"text\" value=\"" + this.key.username + "\">\n    </div>\n    <div class=\"control\">\n      <label>Password:</label>\n      <input class=\"password\" type=\"password\" value=\"" + this.key.password + "\">\n    </div>\n    <button class=\"edit\">Save</button>\n  </div>\n</div>";
      this.el.append(template);
      this.bindSelectors();
      this.key.edited = false;
      return this.el.addClass('open');
    };

    KeyItem.prototype.close = function() {
      var _this = this;
      this.el.removeClass('open');
      return setTimeout(function() {
        return _this.el.find('.dropdown').remove();
      }, 200);
    };

    KeyItem.prototype.edit = function() {
      this.el.find('.dropdown').addClass('edit');
      return this.el_title.focus();
    };

    KeyItem.prototype.save = function() {
      this.el.find('.dropdown').removeClass('edit');
      return this.key.updateAttributes({
        title: this.el.find('input.title').val(),
        url: this.el.find('input.url').val(),
        username: this.el.find('input.username').val(),
        password: this.el.find('input.password').val()
      });
    };

    KeyItem.prototype.copyUsername = function() {
      var el;
      clipboard.set(this.key.username, 'text');
      el = this.el.find('.username');
      el.addClass('copied');
      return setTimeout(function() {
        return el.removeClass('copied');
      }, 500);
    };

    KeyItem.prototype.copyPassword = function() {
      var el;
      clipboard.set(this.key.password, 'text');
      el = this.el.find('.password');
      el.addClass('copied');
      return setTimeout(function() {
        return el.removeClass('copied');
      }, 500);
    };

    KeyItem.prototype.focusInput = function() {
      return Key.trigger('focus-input');
    };

    KeyItem.prototype.blurInput = function() {
      return Key.trigger('blur-input');
    };

    return KeyItem;

  })(Spine.Controller);

  module.exports = KeyItem;

}).call(this);
