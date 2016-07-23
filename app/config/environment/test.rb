require 'yaml'
require 'active_record'
Dir[('app/assets/**/*.rb')].each { |f| require "./#{f}" }
Dir[('app/main/**/*.rb')].each { |f| require "./#{f}" }
Dir[('app/initializers/**/*.rb')].each { |f| require "./#{f}" }
