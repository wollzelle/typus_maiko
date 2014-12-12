module Typus
  module Maiko
    module ClassMethods

      def extended_modules
        (class << self; self end).included_modules
      end

      def typus_maiko(*args)
        cattr_accessor :typus_maiko_options, :typus_maiko_fields
        self.typus_maiko_fields  ||= []
        self.typus_maiko_options ||= {}

        options = args.extract_options!

        args.each do |field|
          self.typus_maiko_fields << field
          self.typus_maiko_options[field] = options
          #serialize field
        end

        extend TemplateMethods unless extended_modules.include?(TemplateMethods)
      end
    end

    module TemplateMethods
      def typus_template(attribute)
        if self.typus_maiko_fields.include? attribute.to_sym
          'maiko'
        else
          super(attribute)
        end
      end
    end

  end
end