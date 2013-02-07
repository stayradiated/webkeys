Spine = require('../libs/spine')
$ = Spine.$
clipboard = gui.Clipboard.get()

class KeyItem extends Spine.Controller

  tag: 'li'

  events:
    'click .main': 'click'
    'dblclick .main': 'dblclick'
    'click .username': 'copyUsername'
    'click .password': 'copyPassword'

  constructor: ->
    super
    @key.bind('select', @select)
    @key.bind('deselect', @deselect)
    @key.bind('open', @open)
    @key.bind('close', @close)

  click: (event) =>
    # @key.select()

  dblclick: (event) =>
    @key.toggleOpen()

  render: =>
    template = """
      <div class="main">
        <div class="button arrow-right"></div>
        <img src="icons/vimeo.png" width="32" height="32">
        <h3>#{@key.title}</h3>
        <p class="username">#{@key.username}</p>
      </div>
    """
    @el.html $(template)
    return @el

  select: =>
    @el.addClass('active')

  deselect: =>
    @el.removeClass('active')

  open: =>
    template = """
      <div class="details">
        <div class="control">
          <label>URL:</label>
          <div class="url">#{@key.url}</div>
        </div>
        <div class="control">
          <label>Username:</label>
          <div class="username copy">#{@key.username}</div>
        </div>
        <div class="control">
          <label>Password:</label>
          <div class="password copy">••••••••••</div>
        </div>
      </div>
    """
    @el.append(template)
    @el.addClass("open")

  close: =>
    @el.removeClass('open')
    setTimeout =>
      @el.find('.details').remove()
    , 200

  copyUsername: =>
    clipboard.set(@key.username, 'text')
    el = @el.find(".username")
    el.addClass("copied")
    setTimeout ->
      el.removeClass("copied")
    , 500

  copyPassword: =>
    clipboard.set(@key.password, 'text')
    el = @el.find(".password")
    el.addClass("copied")
    setTimeout ->
      el.removeClass("copied")
    , 500

module.exports = KeyItem
