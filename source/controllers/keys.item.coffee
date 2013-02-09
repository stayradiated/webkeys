Spine = require('spine')
$ = Spine.$
clipboard = gui.Clipboard.get()

class KeyItem extends Spine.Controller

  tag: 'li'

  selectors:
    '.title': 'title'
    '.username': 'username'
    '.url': 'url'

  events:
    # 'click .main': 'click'
    'click .arrow-down': 'toggleOpen'
    'click button.edit': 'toggleEdit'
    'click .username': 'copyUsername'
    'click .password': 'copyPassword'

    'focus input': 'focusInput'
    'blur input': 'blurInput'

  constructor: ->
    super
    @key.bind('select', @select)
    @key.bind('deselect', @deselect)
    @key.bind('open', @open)
    @key.bind('close', @close)
    @key.bind('open-edit', @edit)
    @key.bind('close-edit', @save)
    @key.bind('update', @update)
    @el.attr('id', "key-#{@key.id}")

  click: (event) =>
    @key.select()

  toggleOpen: (event) =>
    @key.toggleOpen()

  toggleEdit: (event) =>
    @key.toggleEdit()

  bindSelectors: =>
    for selector, name of @selectors
      @["el_" + name] = @el.find(selector)

  update: =>
    @el_title.html @key.title
    @el_username.html @key.username
    @el_url.html @key.url

  render: =>
    template = """
      <div class="main">
        <div class="button arrow-down"></div>
        <img src="icons/#{@key.icon}.png" width="32" height="32">
        <h3 class="title">#{@key.title}</h3>
        <p class="username">#{@key.username}</p>
      </div>
    """
    @el.html $(template)
    @bindSelectors()
    return @el

  select: =>
    @el.addClass('active')

  deselect: =>
    @el.removeClass('active')

  open: =>
    template = """
      <div class="dropdown">
        <div class="details-pane">
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
          <button class="edit">Edit</button>
        </div>
        <div class="edit-pane">
          <div class="control">
            <label>Title:</label>
            <input class="title" type="text" value="#{@key.title}">
          </div>
          <div class="control">
            <label>URL:</label>
            <input class="url" type="text" value="#{@key.url}">
          </div>
          <div class="control">
            <label>Username:</label>
            <input class="username" type="text" value="#{@key.username}">
          </div>
          <div class="control">
            <label>Password:</label>
            <input class="password" type="password" value="#{@key.password}">
          </div>
          <button class="edit">Save</button>
        </div>
      </div>
    """
    @el.append(template)
    @bindSelectors()
    @key.edited = false
    @el.addClass('open')

  close: =>
    @el.removeClass('open')
    setTimeout =>
      @el.find('.dropdown').remove()
    , 200

  edit: =>
    @el.find('.dropdown').addClass('edit')
    @el_title.focus()

  save: =>
    @el.find('.dropdown').removeClass('edit')
    @key.updateAttributes
      title: @el.find('input.title').val()
      url: @el.find('input.url').val()
      username: @el.find('input.username').val()
      password: @el.find('input.password').val()

  copyUsername: =>
    clipboard.set(@key.username, 'text')
    el = @el.find('.username')
    el.addClass('copied')
    setTimeout ->
      el.removeClass('copied')
    , 500

  copyPassword: =>
    clipboard.set(@key.password, 'text')
    el = @el.find('.password')
    el.addClass('copied')
    setTimeout ->
      el.removeClass('copied')
    , 500

  focusInput: =>
    Key.trigger('focus-input')

  blurInput: =>
    Key.trigger('blur-input')

module.exports = KeyItem
