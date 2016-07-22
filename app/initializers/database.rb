require 'pg'
DB = YAML.load_file('./config/database_settings.yml')
@db = PG.connect( dbname: DB['default']['database'] )
