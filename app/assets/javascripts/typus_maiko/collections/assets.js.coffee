class Typus.Maiko.Assets extends Backbone.Collection

  model: Typus.Maiko.Asset

  initialize: (models, options) ->
    { @attributeName, @previewFormat, @locales, @use_ssl } = options
