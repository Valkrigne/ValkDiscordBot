require 'yaml'
require 'active_record'
Dir[('assets/**/*.rb')].each { |f| require "./#{f}" }
Dir[('main/**/*.rb')].each { |f| require "./#{f}" }
Dir[('initializers/**/*.rb')].each { |f| require "./#{f}" }
Dir[('config/**/*.rb')].each { |f| require "./#{f}" }
