module DbMailerRails
  module Generators
    module Helpers
      module MigrationHelper
        def migration_path
          if Rails.version >= '5.0.3'
            db_migrate_path
          else
            'db/migrate'
          end
        end

        def migration_destination_path
          File.join(destination_root, migration_path, "create_#{table_name}.rb")
        end

        def migration_version
          if rails5?
            "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
          end
        end
      end
    end
  end
end
