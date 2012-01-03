require 'spree_core'
require 'globalize3'

module SpreeProductTranslations
  class Engine < Rails::Engine
    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      Spree::Product.class_eval do
        translates :name, :description, :meta_description, :meta_keywords, :copy => true
      end

      Spree::ProductProperty.class_eval do
        translates :value, :copy => true
      end

      Spree::Property.class_eval do
        translates :presentation
      end

      Spree::Prototype.class_eval do
        translates :name, :copy => true
      end

      Spree::Taxonomy.class_eval do
        translates :name, :copy => true
      end

      Spree::Taxon.class_eval do
        translates :name, :description, :copy => true
      end

      Spree::OptionType.class_eval do
        translates :presentation
      end

      Spree::OptionValue.class_eval do
        translates :presentation
      end

      # Enable I18n fallbacks
      require 'i18n/backend/fallbacks'
    end

    config.to_prepare &method(:activate).to_proc
  end
end
