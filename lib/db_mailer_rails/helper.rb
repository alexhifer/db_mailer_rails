module DbMailerRails
  module Helper
    include ActionView::Helpers::TagHelper

    # Render DbMailerRails fields
    # <ul class="db_mailer__fields">
    #   <li class="db_mailer__field"><span>{{[FIELD_NAME]}}</span> - [FIELD_DESCRIPTION]</li>
    #   ...
    # </ul>
    #
    # @param db_mailer_template [DbMailerTemplate]
    # @return [String] html safe string
    def db_mailer_rails_fields_render(db_mailer_template)
      return '' unless db_mailer_template

      list = db_mailer_template.db_mailer.new.fields.map do |field_name, description|
        field = content_tag('span', "{{#{field_name}}}", class: 'db_mailer__field_name')
        content_tag('li', "#{field} - #{description}".html_safe, class: 'db_mailer__field')
      end

      content_tag('ul', list.join.html_safe, class: 'db_mailer__fields')
    end
  end
end
