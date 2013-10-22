#! ----------------------------------------------------------------------------
# typus_maiko
# Copyright 2013 Wollzelle GmbH (http://wollzelle.com). All rights reserved.
# -----------------------------------------------------------------------------

#= require underscore
#= require backbone
#= require jquery-ui

#= require_self
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./templates
#= require_tree ./views

Typus.Maiko = {}

class Typus.Maiko.GalleryApp

  constructor: (options, el) ->
    collection = new Typus.Maiko.Assets options.data, options
    new Typus.Maiko.GalleryView _.extend options, { el, collection }
    this

$.widget.bridge 'maikoGallery', Typus.Maiko.GalleryApp
