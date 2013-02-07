Spine   = require('../libs/spine')
Key     = require('../models/key')
KeyItem = require('./keys.item')
$ = Spine.$

class Keys extends Spine.Controller

  constructor: ->
    super
    Key.bind 'create', @addOne

  refresh: (keys) =>
    @el.empty()
    for key in keys
      view = new KeyItem(key: key)
      @el.prepend view.render()

  addOne: (key) =>
    view = new KeyItem(key: key)
    element = view.render()
    element.addClass('new')
    @el.prepend(element)
    setTimeout ->
      element.removeClass('new')
    , 1

module.exports = Keys
