ruby '2.1.4'
source 'https://rubygems.org'
source 'https://rails-assets.org'

gem 'rails', '4.1.6'
gem 'pg'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'slim'
gem 'honeybadger'
gem 'angular_rails_csrf'
gem 'active_model_serializers'
gem 'attr_extras'
gem 'message_bus'

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring', group: :development
gem 'heroku', group: :development

gem 'unicorn'
gem 'rails_12factor', group: :production

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'jasmine-rails'
  gem 'unicorn-rails'
end

# Bower components via rails-assets.org
#
# After adding one, remember to:
#   * require from application.js / application.scss
#   * restart the Rails server
#
# Updating Angular?
# Force new version builds here if necessary: https://rails-assets.org/components/new
# Run: bundle update rails-assets-angular rails-assets-angular-route rails-assets-angular-mocks rails-assets-angular-animate
#
gem 'rails-assets-angular', '~> 1.2.19'
gem 'rails-assets-angular-route'
gem 'rails-assets-angular-animate'
gem 'rails-assets-angular-gravatar', '~> 0.2.0'
gem 'rails-assets-angular-cookie'
gem 'rails-assets-angular-once'
gem 'rails-assets-font-awesome'
gem 'rails-assets-jquery'
gem 'rails-assets-lodash'

group :development, :test do
  gem 'rails-assets-angular-mocks'
end
