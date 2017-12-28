![DbMailerRails Logo](https://raw.github.com/alexhifer/db_mailer_rails/master/db_mailer_rails.png)

This gem allows you to store mail templates in the database.

Capabilities:

* Sending mails with ActionMailer::MessageDelivery (#deliver_now and #deliver_later methods)
* For replace values and logic in mail templates used Mustache
* To insert mail templates, use the configuration file(*config/db_mailer_templates.yml*) and task(*rake db_mailer_rails:sync*)
* Refactoring an existing project with sending mails is minimal

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'db_mailer_rails'
```

And then execute:

    $ bundle install

Next, you need to run the generator:

    $ rails g db_mailer_rails:install

And also execute the created migration:

    $ rake db:migrate
    
Syncing the configuration file(*config/db_mailer_templates.yml*) with database:
    
    $ rake db_mailer_rails:sync
    
## Usage

##### A quick example of sending:

```ruby
HelloWorldDbMailer.build(OpenStruct.new(name: '')).deliver_now
```

**HelloWorldDbMailer** - this is the inheritance class of DbMailerRails::Base. It provides a mechanism for searching and rendering a template. All db_mailers need to inherit from it. All db_mailers are in the app /db_mailers folder.

##### A quick example of create db_mailer:

1. Create *app/db_mailers/test_db_mailer.rb* with content: 
    ````ruby
    class TestDbMailer < DbMailerRails::Base
      def fields
        super.merge(current_year: 'Current year')
      end
      
      def current_year
        Time.current.year
      end
    end
    ````

2. Add the following lines to *config/db_mailer_rails.yml*:
    ```yaml
    TestDbMailer:
      subject: This test email
      from: Site <no-reply@example.com>
      to: User <user@example.com>
      body: 'Hello, User! Current year is {{current_year}}'
    ```
    
3. Run task:

        $ rake db_mailer_rails:sync
        
4. Use db_mailer in your project:
    
    ```ruby
    TestDbMailer.build.deliver_now
    ````
    
##### Build db_mailer with several attributes:

```ruby
class TestDbMailer < DbMailerRails::Base
  attr_accessor :auth_token
  
  delegate :name, :email, to: :object, prefix: :user
  
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
end
```

Sending a message with multiple attributes:

```ruby
TestDbMailer.build(current_user, auth_token: 'qwerty123')
```

**current_user** - instance of User model with attributes *name* and *email*

##### DbMailer layout

The default template is *app/views/layouts/mailer.html.erb*.

To change the template for the db_mailer, you need to override method *layout* in your db_mailer:

```ruby
def layout
  'custom_mail_template'
end
```

##### Development of mail template editing module


For the user to know what variables he can use in the template, you need helper *db_mailer_rails_fields_render*:

```ruby
db_mailer_rails_fields_render(template)
```

**template** - instance of DbMailerTemplate

This helper render:

```html
  <ul class="db_mailer__fields">
    <li class="db_mailer__field"><span>{{user_name}}</span> - User name</li>
    <li class="db_mailer__field"><span>{{user_email}}</span> - User e-mail</li>
  </ul>
```

## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `rake spec` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/db_mailer_rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DbMailerRails project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/db_mailer_rails/blob/master/CODE_OF_CONDUCT.md).
