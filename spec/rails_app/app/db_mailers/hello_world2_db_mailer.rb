class HelloWorld2DbMailer < DbMailerRails::Base
  delegate :name, :email, to: :object, prefix: :user
  attr_accessor :auth_token

  def build(object, **args)
    self.auth_token = args[:auth_token]
    super
  end

  def fields
    super.merge(
      user_name: 'User name',
      user_email: 'User email',
      auth_token: 'Auth token'
    )
  end

  def layout
    'mailer_with_default_image'
  end

  def mail_attachments
    add_inline_image('logo.png')
  end
end
