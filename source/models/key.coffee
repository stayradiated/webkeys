Spine = require('spine')

class global.Key extends Spine.Model

	@configure 'Key',
		'title','url', 'username', 'password', 'icon'
		'created_on', 'open', 'edited'

	@extend @Local

	@filter: (query) =>
		keys = []
		query = query.toLowerCase()
		@each (key) ->
			if key.title.toLowerCase().indexOf(query) > -1
				keys.push key.id
		return keys

	@deselectAll: =>
		selected = @select (key) ->
			return key.selected ? false
		for key in selected
			key.selected = false
			key.trigger('deselect')

	@closeAll: =>
		open = @select (key) -> return key.open ? false
		for key in open
			if key.edited then key.toggleEdit(false)
			key.updateAttribute('open', false)
			key.trigger('close')

	select: =>
		Key.deselectAll()
		@selected = true
		@trigger('select')

	toggleOpen: (value) =>
		open = value ? !@open
		Key.closeAll()
		return if open is false
		@updateAttribute('open', true)
		@trigger('open')

	toggleEdit: (value) =>
		@updateAttribute 'edited', if value then value else !@edited
		@trigger if @edited then 'open-edit' else 'close-edit'

module.exports = Key
