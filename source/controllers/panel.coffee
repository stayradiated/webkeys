Spine = require('../libs/spine')
Key   = require('../models/key')
Keys  = require('./keys')

class Panel extends Spine.Controller

  window: gui.Window.get()

  events:
    'mousedown .add-key': 'createKey'
    'click .minimize': 'minimize'
    'click .maximize': 'maximize'
    'click .close': 'close'

  constructor: ->
    super

  createKey: =>
    Key.create
      title: "Title"
      url: "URL"
      username: "Username"
      password: "Password"
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
