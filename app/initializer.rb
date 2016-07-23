require 'yaml'
require 'active_record'
Dir[('main/**/*.rb')].each { |f| require "./#{f}" }
Dir[('initializers/**/*.rb')].each { |f| require "./#{f}" }
