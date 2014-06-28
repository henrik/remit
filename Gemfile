ruby '2.1.2'
source 'https://rubygems.org'
source 'https://rails-assets.org'

gem 'rails', '4.1.2'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'slim'
gem 'honeybadger'
gem 'pusher'
gem 'angular_rails_csrf'
gem 'active_model_serializers'
gem 'attr_extras'

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring', group: :development

gem 'unicorn'
gem 'rails_12factor', group: :production

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pusher-fake'
  gem 'jasmine-rails'
end

# Bower components via rails-assets.org
#
# After adding one, remember to:
#   * require from application.js / application.scss
#   * restart the Rails server
#
gem 'rails-assets-angular'
gem 'rails-assets-angular-route'
gem 'rails-assets-angular-animate'
gem 'rails-assets-angular-gravatar', '~> 0.2.0'
gem 'rails-assets-angular-pusher'
gem 'rails-assets-pusher'
gem 'rails-assets-angular-cookie'
gem 'rails-assets-angular-once'
gem 'rails-assets-font-awesome'

group :development, :test do
  gem 'rails-assets-angular-mocks'
end
