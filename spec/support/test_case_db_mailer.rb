class TestCaseDbMailer < DbMailerRails::Base
  delegate :name, to: :object, prefix: :app

  def fields
    super.merge(
      user_name: 'User test name',
      user_email: 'User test e-mail address',
      app_name: 'Application name'
    )
  end

  def user_name
    'User'
  end

  def user_email
    'db_mailer_rails@example.com'
  end

  def mail_attachments
    add_inline_image('logo.png')
  end
end
