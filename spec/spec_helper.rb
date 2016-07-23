require 'rubygems'
require 'shoulda-matchers'
# Coverage must be enabled before the application is loaded.
require 'simplecov'
require 'support/factory_girl'

# Writes the coverage stat to a file to be used by Cane.
class SimpleCov::Formatter::QualityFormatter
  def format(result)
    SimpleCov::Formatter::HTMLFormatter.new.format(result)
    File.open('coverage/covered_percent', 'w') do |f|
      f.puts result.source_files.covered_percent.to_f
    end
  end
end

SimpleCov.formatter = SimpleCov::Formatter::QualityFormatter

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'
  add_group  'Models', 'app/main/models'
end

require File.expand_path('../../app/config/environment/test', __FILE__)

RSpec.configure do |config|

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = 'random'

  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)


  config.before(:all) do
    FactoryGirl.reload
  end

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :active_record
      with.library :active_model
    end
  end
end
