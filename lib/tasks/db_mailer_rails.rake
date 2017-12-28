require 'db_mailer_rails'

namespace :db_mailer_rails do
  desc 'Syncing DbMailerRails templates sync_file_path(default config/db_mailer_rails.yml) file with database.'
  task :sync, [:force] => :environment do |_task, args|
    force = args[:force]
    mail_template_class = DbMailerRails.template_model_class.constantize

    config_path = Rails.root.join(DbMailerRails.sync_file_path).to_s
    mail_templates_from_file = YAML.load_file(config_path)

    # Remove from database if not exist in configuration file
    mail_template_class.where('db_mailer_class NOT IN(?)', mail_templates_from_file.keys).delete_all

    mail_templates_from_file.each do |db_mailer_class, attributes|
      db_mail_template = mail_template_class.find_or_initialize_by(db_mailer_class: db_mailer_class)
      next if !force && !db_mail_template.new_record?

      db_mail_template.assign_attributes(attributes)

      if db_mail_template.save
        puts "#{db_mailer_class} synchronization is successful."
      else
        puts "#{db_mailer_class} synchronization is failed."
      end
    end
  end
end
