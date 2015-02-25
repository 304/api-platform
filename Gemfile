source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '4.2.0'
gem 'grape', '0.10.1'
gem 'pg'
gem 'hashie_rails'
gem 'unicorn'
gem 'rake'

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
end

