class Typus.Maiko.GalleryItemView extends Backbone.View

  tagName: 'li'

  className: 'mk-item mk-image'

  template: JST['typus_maiko/templates/image']

  events:
    'click .mk-remove-btn': 'removeItem'
    'keyup .mk-caption': 'escapeEdit'

  initialize: ->
    @collection = @model.collection
    @render()

  render: ->
    data = @templateData()
    @$el.html @template data

  templateData: ->
    extra = { locales: @collection.locales }
    _.extend @model.attributes, extra

  removeItem: (e) ->
    e.preventDefault()
    @collection.remove @model
    @remove()

  escapeEdit: (e) ->
    if e.keyCode is 27 then e.target.blur()