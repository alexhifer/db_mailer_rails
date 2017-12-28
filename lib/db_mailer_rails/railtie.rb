module DbMailerRails
  class Railtie < Rails::Railtie
    rake_tasks { load 'tasks/db_mailer_rails.rake' }
  end
end
