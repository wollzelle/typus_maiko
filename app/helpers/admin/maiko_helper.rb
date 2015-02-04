module Admin::MaikoHelper

  @@maikojs_url = "http://cdn.maikoapp.com/maiko.js"

  @@default_preview_options = { width: 170, height: 100, crop: false }

  ##
  # View helper for generating maiko urls.
  #

  def maiko_image_for(url, format)
    return "#" if url.nil? || format.nil?

    re = /\/(?=[^\/]*$).*\..*/
    [url.gsub(re, ''), format].join('/')
  end

  ##
  # Internal methods used in the admin template.
  #

  def maikojs_url
    @@maikojs_url
  end

  def maiko_preview_format(model, attribute)
    options = model.class.typus_maiko_options[attribute.to_sym][:preview] || {}
    config = @@default_preview_options.merge(options)
    width    = config[:width]
    height   = config[:height]
    crop     = config[:crop]
    fill     = crop ? "f" : ""
    geometry = "#{width}x#{height}"
    { :width => width, :height => height, :url => "#{fill}#{geometry}.jpg" }
  end

  def maiko_attribute_name(model, attribute)
    model = ActiveModel::Naming.param_key(model) # => model_name
    "#{model}[#{attribute}]"
  end

  def maiko_account(model, attribute)
    model.class.typus_maiko_options[attribute.to_sym][:account]
  end

  def maiko_stack(model, attribute)
    model.class.typus_maiko_options[attribute.to_sym][:stack]
  end

  def maiko_use_ssl(model, attribute)
    model.class.typus_maiko_options[attribute.to_sym][:use_ssl] || false
  end

  def maiko_json(model, attribute)
    gallery_items = model[attribute].delete_if {|x| x == ""} rescue nil
    raw gallery_items.to_json rescue []
  end

  def maiko_locales(model, attribute)
    if maiko_translatable?(model, attribute)
      raw Typus::Translate::Configuration.config['locales'].keys.to_json
    else
      raw [].to_json
    end
  end

  def maiko_translatable?(model, attribute)
    model.class.typus_maiko_options[attribute.to_sym][:translatable] || false
  end

  def maiko_iframe_option(model, attribute)
    model.class.typus_maiko_options[attribute.to_sym][:iframe] == false ? false : true
  end

end