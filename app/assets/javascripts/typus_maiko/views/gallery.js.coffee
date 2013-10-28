class Typus.Maiko.GalleryView extends Backbone.View

  itemView: Typus.Maiko.GalleryItemView

  events:
    'click .mk-add-btn': 'choose'

  initialize: (options) ->
    { @accountId, @stackId, @iframe } = options
    @setElements()
    @listen()
    @makeSortable()
    @onReset()

  setElements: ->
    @gallery = @$('.mk-gallery')
    @addButton = @$('.mk-item-add')

  listen: ->
    @collection.on 'add', @onAdd
    @collection.on 'remove', @onRemove
    @collection.bind 'reset', @onReset

  choose: (e) ->
    e.preventDefault()
    Maiko.choose { @accountId, @stackId, @iframe, success: @onChoose }

  onChoose: (assets) =>
    @collection.add assets

  onAdd: (model) =>
    @addOne model, true

  onReset: =>
    @collection.each @addOne
    @triggerRefresh()

  addOne: (model, refresh = false) =>
    item = new @itemView({ model }).el
    @$el.find('.mk-empty').remove()
    @addButton.before item
    @triggerRefresh() if refresh

  onRemove: =>
    template = JST['typus_maiko/templates/empty']
    if @collection.length is 0
      @gallery.append(template({ attributeName: @collection.attributeName }))

  triggerRefresh: ->
    $(window).trigger 'translate:refresh'

  makeSortable: ->
    @$el.sortable {
      items: '.mk-image'
      cursor: 'move'
      helper: 'clone'
      revert: 50
    }
