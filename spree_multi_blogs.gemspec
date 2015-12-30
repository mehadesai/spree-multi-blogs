# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_multi_blogs'
  s.version     = '0.4.0'
  s.summary     = 'Multiple Blogs for your Spree Store'
  s.description = 'Allows your Spree E-Commerce platform to have multiple private/public blogs and blog posts'
  s.required_ruby_version = '>= 2.1.0'

  s.author    = 'Meha Desai'
  s.email     = 'meha@urbanladder.com'
  s.homepage  = 'https://www.urbanladder.com'

  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 3.0.0'

  s.add_development_dependency 'capybara', '~> 2.4'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 3.2.0'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'launchy'

end
