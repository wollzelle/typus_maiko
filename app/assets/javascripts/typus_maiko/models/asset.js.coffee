class Typus.Maiko.Asset extends Backbone.Model

  defaults:
    caption: []

  initialize: ->
    @setPreviewFormat()
    @setAttributeName()
    @setUrl() unless @attributes.url?
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
    key = if @collection.use_ssl? then 'maiko_https_url' else 'maiko_url'
    @set 'url', @get key
    @set { maiko_url: undefined, maiko_https_url: undefined}, unset: true, silent:true

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
