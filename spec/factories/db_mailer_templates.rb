FactoryBot.define do
  factory :db_mailer_template do
    db_mailer_class { 'TestCaseDbMailer' }
    subject { '{{app_name}} - Hello world!' }
    from { 'Site <no-reply@example.com>' }
    to { '{{user_name}} <{{user_email}}>' }
    body do
      <<BODY
Hello, {{user_name}}!<br><br>
This is your first e-mail with <b>DbMailerRails gem</b> :)
BODY
    end
  end
end
