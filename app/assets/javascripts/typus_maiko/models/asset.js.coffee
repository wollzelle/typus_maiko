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
  setUrl: ->
    key = if @collection.useSSL is true then 'maiko_https_url' else 'maiko_url'
    @set 'url', @get key
    @set { maiko_url: undefined, maiko_https_url: undefined}, unset: true, silent:true

  # Set asset thumbnail.
  setThumbnail: ->
    { url, previewFormat } = @attributes
    thumbnail = Maiko.image url, previewFormat
    thumbnail = thumbnail.replace('http://cdn.maikoapp.com', 'https://maiko.a.ssl.fastly.net') if window.location.protocol == 'https:'
    @set { thumbnail }

  setCaption: ->
    if title = @get 'title'
      @set 'caption', title
