Spine = require('spine')
fs = require('fs')
Q = require('q')
UpdateAttribute = require('./updateAttr')

Spine.Model.Local =
  extended: ->
    @bind 'create', @saveLocal
    @bind 'updateAttr', @updateHandler
    @fetch @loadLocal
    @extend UpdateAttribute

  saveList: (keys) ->
    files = []
    keys.each (key) ->
      files.push(key.id)
    json = JSON.stringify(files)
    Storage.writeFile('keys/index', json)

  saveLocal: (model) ->
    filename = 'keys/' + model.id + '.webkey'
    values = ['id', 'title', 'url', 'username', 'password', 'icon']
    json = JSON.stringify(model.toJSON(), values, 4)
    Storage.writeFile(filename, json)
    @saveList(@)

  updateHandler: (model, attr, value, old) ->
    if attr in ['title', 'url', 'username', 'password', 'icon']
      @saveLocal(model)

  loadLocal: ->
    Storage.loadKeys().then (results) =>
      @refresh(results or [], clear: true)

    return

class Storage extends Spine.Controller
  constructor: ->
    super

  @readDir: (path) ->
    deferred = Q.defer()
    fs.readdir path, (err, files) ->
      if err then return deferred.reject(err)
      deferred.resolve(files)
    return deferred.promise

  @getIcons: =>
    deferred = Q.defer()
    icons = []
    @readDir('./icons').then (files) ->
      for filename in files
        extension = filename[-4..]
        continue unless extension is '.png'
        icons.push filename[..-5]
      deferred.resolve(icons)
    return deferred.promise

  @writeFile: (filename, data) ->
    fs.writeFile(filename, data, 'utf8')

  @loadKeys: ->
    deferred = Q.defer()
    keys = []
    fs.readFile 'keys/index', (err, data) ->
      if err then return deferred.reject(err)
      index = JSON.parse(data)
      addKey = (err, data) ->
        if err then return
        key = JSON.parse(data)
        keys.push(key)
        if keys.length is index.length
          deferred.resolve(keys)
      for id in index
        fs.readFile("keys/#{id}.webkey", addKey)
    return deferred.promise


module.exports = Storage
