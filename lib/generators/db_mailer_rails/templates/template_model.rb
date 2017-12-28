require 'db_mailer_rails/models/methods'
require 'db_mailer_rails/models/validatable'

class <%= model_class %> < <%= model_superclass %>
  include DbMailerRails::Models::Methods
  include DbMailerRails::Models::Validatable
end
