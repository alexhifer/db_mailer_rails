require 'db_mailer_rails/models/methods'
require 'db_mailer_rails/models/validatable'

class DbMailerTemplate < ApplicationRecord
  include DbMailerRails::Models::Methods
  include DbMailerRails::Models::Validatable
end
