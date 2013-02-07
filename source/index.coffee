# Dependencies
jquery = require("jquery")
Spine = require('./app/libs/spine')
$ = Spine.$

global.gui = require("nw.gui")
global.document = document

# Controllers
Panel = require('./app/controllers/panel')
Keys  = require('./app/controllers/keys')

class App extends Spine.Controller
  constructor: ->
    super
    new Panel el: $('header.page')
    new Keys  el: $('ul.keys')

jQuery ->
  new App
    el: $("body")
