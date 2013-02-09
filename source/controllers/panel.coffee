Spine = require('spine')
Key   = require('../models/key')
Keys  = require('./keys')
Storage = require('../utils/storage')

class Panel extends Spine.Controller

  window: gui.Window.get()

  events:
    'mousedown .add-key': 'createKey'
    'click .minimize': 'minimize'
    'click .maximize': 'maximize'
    'click .close': 'close'
    'dblclick': 'inspect'

  constructor: ->
    super
    Storage.getIcons().then (icons) =>
      @icons = icons

  createKey: =>

    # Temporary -- because I want to
    length = @icons.length
    index = Math.floor Math.random() * length
    icon = @icons[index]

    Key.create
      title: ''
      url: ''
      username: ''
      password: ''
      icon: icon
      created_on: Date.now()

  close: =>
    @window.reloadDev()
    # @window.close()

  inspect: =>
    @window.showDevTools()

  minimize: =>
    @window.minimize()

  maximize: =>
    @window.maximize()

module.exports = Panel
