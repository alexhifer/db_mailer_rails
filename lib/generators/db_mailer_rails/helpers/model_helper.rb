module DbMailerRails
  module Generators
    module Helpers
      module ModelHelper
        private

        def table_name
          @table_name ||= model_class.tableize.gsub('/', '_')
        end

        def model_exists?
          File.exist?(model_path)
        end

        def model_path
          @model_path ||= File.join(destination_root, 'app', 'models', "#{model_class.underscore}.rb")
        end

        def model_class
          @model_class ||= DbMailerRails.template_model_class
        end

        def model_superclass
          rails5? ? 'ApplicationRecord' : 'ActiveRecord::Base'
        end
      end
    end
  end
end
