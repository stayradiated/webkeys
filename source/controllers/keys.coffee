Spine   = require('spine')
Key     = require('../models/key')
KeyItem = require('./keys.item')
$ = Spine.$

class Keys extends Spine.Controller

  elements:
    'ul.keys': 'ul'
    '.searchBox': 'searchBox'

  events:
    'keyup .searchBox': 'search'

  constructor: ->
    super
    Key.bind 'create', @addOne
    Key.bind 'refresh', @refresh
    return

  items: []

  searchVisible: false

  showSearch: =>
    return unless not @searchVisible
    searchVisible = true
    @el.addClass('search')
    @searchBox.focus()

  hideSearch: =>
    searchVisible = false
    @searchBox.blur()
    @el.removeClass('search')
    @searchBox.val('')
    @search()

  search: =>
    query = @searchBox.val()
    keys = Key.filter(query)
    @filter(keys)

  filter: (keys) =>
    @ul.find('li').map (index, element) =>
      id = element.id[4..]
      style = if keys.indexOf(id) < 0 then 'none' else 'block'
      element.style.display = style
    return

  refresh: (keys) =>
    view.release() for view in @items
    @ul.empty()
    for key in keys
      view = new KeyItem(key: key)
      @ul.prepend view.render()
    return

  addOne: (key) =>
    view = new KeyItem(key: key)
    @items.push view
    element = view.render()
    @ul.prepend(element)
    key.toggleOpen(true)
    key.toggleEdit(true)
    return

module.exports = Keys
