###
Trigger updateAttr on model with the attribute that was modified and the new and
old versions of that attribute

Based on Spine-Attribute-Events by Mitch Lloyd
https://github.com/mitchlloyd/Spine-Attribute-Events
###

_ = require "underscore"

ClassMethods =

  # Clone model
  setAttributesSnapshot: (model) ->
    data = model.toJSON()
    # Clone arrays
    for k, v of data
      if v instanceof Array
        data[k] = v.slice(0)
    @_attributesSnapshots[model.cid] = data


  # Return clone
  getAttributesSnapshot: (model) ->
    @_attributesSnapshots[model.cid]

AttributeTracking =
  extended: ->
    @_attributesSnapshots = {}

    @bind 'refresh create', (models) =>
      # Spine is a little quirky with refresh({clear: true}) and passes false.
      # So we need this fix for now.
      models or= @all()

      # models could be an array of models or one model.
      if models.length?
        @setAttributesSnapshot(model) for model in models
      else
        @setAttributesSnapshot(models)

    @bind 'update', (model, options) =>
      for key, value of model.attributes()
        old = @getAttributesSnapshot(model)[key]
        unless _.isEqual(old, value)
          model.trigger "updateAttr", key, value, old, options
          model.trigger "update:#{key}", value, old, options
      @setAttributesSnapshot(model)

    @extend ClassMethods

Spine?.AttributeTracking = AttributeTracking
module?.exports = AttributeTracking
