require 'rails'

require 'db_mailer_rails/railtie' if defined?(Rails::Railtie)
require 'db_mailer_rails/base'
require 'db_mailer_rails/helper'
ActionView::Base.send :include, DbMailerRails::Helper

module DbMailerRails
  # Template class
  mattr_accessor :template_model_class
  @@template_model_class = 'DbMailerTemplate'

  # Sync file
  mattr_accessor :sync_file_path
  @@sync_file_path = 'config/db_mailer_templates.yml'

  def self.setup
    yield self
  end
end
