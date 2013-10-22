module Typus
  module Maiko
    if defined?(Rails)
      require 'jquery-rails'
      require 'eco'
      require 'maiko/engine'
      require 'maiko/version'
    end

    if defined?(ActiveRecord)
      require 'maiko/class_methods'
      ActiveRecord::Base.extend(Typus::Maiko::ClassMethods)
    end

  end
end