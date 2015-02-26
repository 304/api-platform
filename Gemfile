source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '4.2.0'
gem 'grape', '0.10.1'
gem 'grape-rabl'
gem 'pg'
gem 'hashie_rails'
gem 'unicorn'
gem 'rake'
gem 'bcrypt', '~> 3.1.7'
gem 'api-auth'
gem 'oj'
gem 'oj_mimic_json'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rest-client'
end

