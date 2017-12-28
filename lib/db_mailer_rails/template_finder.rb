module DbMailerRails
  class TemplateFinder
    attr_accessor :db_mail_template

    # @param db_mailer_class [DbMailerRails::Base]
    def initialize(db_mailer_class)
      self.db_mail_template = find(db_mailer_class)
    end

    private

    def find(db_mailer_class)
      db_mail_template_class.find_by!(db_mailer_class: db_mailer_class.name)
    end

    def db_mail_template_class
      DbMailerRails.template_model_class.constantize rescue nil
    end
  end
end
