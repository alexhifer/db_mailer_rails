module DbMailerRails
  module Models
    module Validatable
      extend  ActiveSupport::Concern

      included do
        validates :db_mailer_class, :subject, :from, :to, :body, presence: true, length: { minimum: 3 }
        validates :subject, length: { maximum: 80 }
        validates :from, length: { maximum: 64 }
        validates :to, length: { maximum: 64 }
      end
    end
  end
end
