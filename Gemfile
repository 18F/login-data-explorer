source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.5.1'

gem 'actionmailer', '~> 5.2.1'
gem 'activerecord', '~> 5.2.1'
gem 'activerecord5-redshift-adapter'
gem 'blazer'
gem 'figaro'
gem 'omniauth_login_dot_gov', git: 'git@github.com:18F/omniauth_login_dot_gov.git'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'railties', '~> 5.2.1'
gem 'sass-rails', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-rails'
end

group :development do
  gem 'bummr', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'rspec-rails'
  gem 'webmock'
end
