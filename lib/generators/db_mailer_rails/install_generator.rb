require 'rails/generators/base'
require 'rails/generators/active_record'
require 'active_support/core_ext/string'

require 'generators/db_mailer_rails/helpers/model_helper'
require 'generators/db_mailer_rails/helpers/migration_helper'

module DbMailerRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Helpers::ModelHelper
      include Helpers::MigrationHelper
      include ActiveRecord::Generators::Migration

      desc 'Creates a DbMailerRails initializer, migration, model, sync file, test db_mailer for your application.'

      INITIALIZER_FILE = 'db_mailer_rails.rb'.freeze
      TEST_DB_MAILER_FILE = 'hello_world_db_mailer.rb'.freeze

      source_root File.expand_path('../templates', __FILE__)

      def copy_sync_file
        copy_file '../../../../config/db_mailer_templates.yml', sync_file_path
      end

      def copy_template_model_file
        template 'template_model.rb', model_path
      end

      def copy_initializer_file
        template 'initializer.rb', "config/initializers/#{INITIALIZER_FILE}"
      end

      def copy_test_db_mailer_file
        copy_file TEST_DB_MAILER_FILE, "app/db_mailers/#{TEST_DB_MAILER_FILE}"
      end

      def copy_migration_file
        migration_template 'migration.rb', migration_destination_path, migration_version: migration_version
      end

      private

      def rails5?
        Rails.version.start_with? '5'
      end

      def sync_file_path
        DbMailerRails.sync_file_path
      end
    end
  end
end
