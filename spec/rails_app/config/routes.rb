Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'send_email', to: 'test#send_email', as: 'test_send_email'
  get 'send_email_2', to: 'test#send_email_2', as: 'test_send_email_2'

  root 'test#index'
end
