class Typus.Maiko.Asset extends Backbone.Model

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
    if public_url = @get 'public_url'
      @set 'url', public_url
      @unset 'public_url'

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
    Maiko.viewUrl url, format

  convertFluxiomUrl: (url, format) ->
    path = url.match(/(.*\/([^_|.]*))/)[0]
    path + '_' + format
