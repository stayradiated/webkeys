# Dependencies
jquery = require('jquery')
Spine = require('spine')
$ = Spine.$

global.gui = require('nw.gui')
global.document = document

# Utils
require('./app/utils/updateAttr')
Storage = require('./app/utils/storage')

# Controllers
Panel   = require('./app/controllers/panel')
Keys    = require('./app/controllers/keys')

# Models
Key  = require('./app/models/key')

class App extends Spine.Controller

  validKeys = [
    # 0 - 9
    48, 49, 50, 51, 52, 53, 54, 55, 56, 57
    # A - Z
    65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90
    # Symbols
    186, 187, 188, 189, 190, 191, 219, 220, 221, 222
  ]

  events:
    'keydown': 'keydown'

  constructor: ->
    super
    @panel = new Panel el: $('header.page')
    @keys = new Keys  el: $('section.page')

    Key.fetch()

    @key_listening = on
    Key.bind 'focus-input', =>
      @key_listening = off
    Key.bind 'blur-input', =>
      @key_listening = on

  keydown: (event) =>
    return unless @key_listening
    if event.keyCode is 27
      @keys.hideSearch()
    else if validKeys.indexOf(event.keyCode) > -1
      @keys.showSearch()

jQuery ->
  new App
    el: $('body')
