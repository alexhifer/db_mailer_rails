require 'action_mailer'
require 'db_mailer_rails/replacer'
require 'db_mailer_rails/template_finder'

module DbMailerRails
  class Base < ActionMailer::Base
    attr_accessor :object

    def build(object = nil, **_args)
      self.object = object
      replacer = Replacer.new(fields_with_data)
      finder = TemplateFinder.new(self.class)
      template = finder.db_mail_template

      mail_params = {
        from: replacer.replace(template.from),
        to: replacer.replace(template.to),
        subject: replacer.replace(template.subject)
      }

      # add attachments to mail
      mail_attachments

      mail(mail_params) do |format|
        format.html { render html: replacer.replace(template.body).html_safe, layout: layout_by_environment }
      end
    end

    def fields
      {}
    end

    def mail_attachments
    end

    private

    def add_inline_image(file_path)
      file = file_path.split('/').last
      image_path = Rails.root.join('app', 'assets', 'images', file_path)
      attachments.inline[file] = File.read(image_path) if File.exists?(image_path)
    end

    def layout
      'mailer'
    end

    def layout_by_environment
      Rails.env.test? ? false : layout
    end

    def fields_with_data
      @fields_with_data ||= fields.keys.each_with_object({}) do |field_name, res|
        res[field_name] = self.send(field_name)
      end
    end
  end
end
