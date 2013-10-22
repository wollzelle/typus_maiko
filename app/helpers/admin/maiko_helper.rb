module Admin::MaikoHelper

  @@default_preview_options = { width: 170, height: 100, crop: false }

  ##
  # View helper for generating maiko urls.
  #

  def maiko_image_for(url, format)
    return "#" if url.nil? || format.nil?

    # backwards compatiblity for fluxiom urls
    if url.include? 'flxd.it'
      url = url.match(/(.*\/([^_|.]*))/)[0] # url without format
      format.gsub!(/^([^._])(.*)/, '_\1\2') # clean up
      return url + format
    else
      re = /\/(?=[^\/]*$).*\..*/
      [url.gsub(re, ''), format].join('/')
    end
  end

  ##
  # Internal methods used in the admin template.
  #

  def maiko_get_preview_format(model, attribute)
    options = model.class.typus_maiko_options[attribute.to_sym][:preview] || {}
    config = @@default_preview_options.merge(options)
    width    = config[:width]
    height   = config[:height]
    crop     = config[:crop]
    fill     = crop ? "f" : ""
    geometry = "#{width}x#{height}"
    { :width => width, :height => height, :url => "#{fill}#{geometry}.jpg" }
  end

  def maiko_get_attribute_name(model, attribute)
    model = ActiveModel::Naming.param_key(model) # => model_name
    "#{model}[#{attribute}]"
  end

  def maiko_get_account(model, attribute)
    model.class.typus_maiko_options[attribute.to_sym][:account]
  end

  def maiko_get_stack(model, attribute)
    model.class.typus_maiko_options[attribute.to_sym][:stack]
  end

  def maiko_get_json(model, attribute)
    gallery_items = model[attribute].delete_if {|x| x == ""} rescue nil
    raw gallery_items.values.to_json rescue []
  end

  def maiko_get_locales(model, attribute)
    if maiko_translatable?(model, attribute)
      raw maiko_locales.keys.to_json
    else
      raw [].to_json
    end
  end

  def maiko_translatable?(model, attribute)
    model.class.typus_maiko_options[attribute.to_sym][:translatable] || false
  end

  def maiko_locales
    Typus::Translate::Configuration.config['locales']
  end

end