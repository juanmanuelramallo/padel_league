source "https://rubygems.org"

gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "importmap-rails"
gem "jbuilder"
gem "madmin"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 7.2.1"
gem "redis", ">= 4.0.1"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "brakeman", require: false
  gem "factory_bot_rails"
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rspec-rails", "~> 6.1.0"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "annotate"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
