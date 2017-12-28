require 'generators/db_mailer_rails/install_generator'

RSpec.describe DbMailerRails::Generators::InstallGenerator, type: :generator do
  destination File.expand_path('../../../../tmp', __FILE__)

  before do
    prepare_destination
    run_generator
  end

  # cleanup the tmp directory
  after { prepare_destination }

  it 'copy sync file' do
    expect(destination_root).to have_structure {
      directory 'config' do
        file 'db_mailer_templates.yml' do
          contains 'HelloWorldDbMailer'
        end
      end
    }
  end

  it 'copy initializer' do
    expect(destination_root).to have_structure {
      directory 'config' do
        directory 'initializers' do
          file 'db_mailer_rails.rb' do
            contains 'DbMailerRails.setup'
            contains 'config.template_model_class'
            contains 'config.sync_file_path'
          end
        end
      end
    }
  end

  it 'copy template model' do
    expect(destination_root).to have_structure {
      directory 'app' do
        directory 'models' do
          file 'db_mailer_template.rb' do
            contains 'class DbMailerTemplate <'
          end
        end
      end
    }
  end

  it 'copy test db_mailer file' do
    expect(destination_root).to have_structure {
      directory 'app' do
        directory 'db_mailers' do
          file 'hello_world_db_mailer.rb' do
            contains 'class HelloWorldDbMailer'
          end
        end
      end
    }
  end

  it 'copy migration' do
    expect(destination_root).to have_structure {
      directory 'db' do
        directory 'migrate' do
          migration 'create_db_mailer_templates' do
            contains 'class CreateDbMailerTemplates < ActiveRecord::Migration'
            contains 'string :db_mailer_class'
            contains 'string :subject'
            contains 'string :from'
            contains 'string :to'
            contains 'text :body'
          end
        end
      end
    }
  end
end
