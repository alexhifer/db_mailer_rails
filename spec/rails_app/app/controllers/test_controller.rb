class TestController < ApplicationController
  def index
    @db_mailer_template = DbMailerTemplate.first
  end

  def send_email
    send_mail_message(HelloWorldDbMailer.build(OpenStruct.new(name: 'rails_app')))

    flash.notice = 'E-mail "Hello World" is successfully sended.'

    redirect_to root_path
  end

  def send_email_2
    current_user = OpenStruct.new(name: 'User', email: 'db_mailer_rails@example.com')
    send_mail_message(HelloWorld2DbMailer.build(current_user, auth_token: '123456'))

    flash.notice = 'E-mail "Hello World (change layout)" is successfully sended.'

    redirect_to root_path
  end

  private

  def send_mail_message(mail_message)
    mail_message.try(:deliver_now) || mail_message.try(:deliver)
  end
end
