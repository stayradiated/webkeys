Spine = require('../libs/spine')

class global.Key extends Spine.Model
  @configure 'Key',
    'title','url', 'username', 'password',
    'created_on', 'open'

  @deselect: =>
    selected = @select (key) ->
      return key.selected ? false
    for key in selected
      key.selected = false
      key.trigger('deselect')

  select: =>
    Key.deselect()
    @selected = true
    @trigger('select')

  @close: =>
    open = @select (key) -> return key.open ? false
    for key in open
      key.updateAttribute('open', false)
      key.trigger('close')

  toggleOpen: =>
    open = !@open ? true
    Key.close()
    return if open is false
    @updateAttribute('open', true)
    @trigger('open')

module.exports = Key
