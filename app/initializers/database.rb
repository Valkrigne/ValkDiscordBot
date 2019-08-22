require 'pg'
db_config       = YAML::load(File.open('./app/config/database.yml'))[ENV['ENV'] || 'development']
db_config_admin = db_config.merge({'database' => 'postgres', 'schema_search_path' => 'public'})
ActiveRecord::Base.establish_connection(db_config)
