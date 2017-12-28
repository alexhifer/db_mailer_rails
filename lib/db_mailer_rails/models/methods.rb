module DbMailerRails
  module Models
    module Methods
      extend  ActiveSupport::Concern

      def db_mailer
        db_mailer_class.constantize rescue nil
      end
    end
  end
end
