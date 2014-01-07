class Typus.Maiko.Asset extends Backbone.Model

  urlKeys:
    ['public_url', 'maiko_url']

  defaults:
    caption: []

  initialize: ->
    @setPreviewFormat()
    @setAttributeName()
    @setUrl()
    @setThumbnail()
    @setCaption()

  setPreviewFormat: ->
    previewFormat = @collection.previewFormat
    @set { previewFormat }

  # Set the name used in the form for saving this model.
  setAttributeName: ->
    attributeName = @collection.attributeName + '[' + @cid + ']'
    @set { attributeName }

  # Set / normalize the url.
  # Provides backwards compatibility with typus_fluxiom
  setUrl: ->
    for key in @urlKeys
      if value = @get key
        @set 'url', value
        @unset key

  # Set asset thumbnail.
  # Provides backwards compatibility with typus_fluxiom
  setThumbnail: ->
    { url, previewFormat } = @attributes
    convert = if url.match('flxd.it')? then 'convertFluxiomUrl' else 'convertMaikoUrl'
    thumbnail = this[convert] url, previewFormat
    @set { thumbnail }

  setCaption: ->
    if title = @get 'title'
      @set 'caption', title

  convertMaikoUrl: (url, format) ->
    Maiko.image url, format

  convertFluxiomUrl: (url, format) ->
    path = url.match(/(.*\/([^_|.]*))/)[0]
    path + '_' + format
