BOT_ENV = HashWithIndifferentAccess.new
BOT_ENV.update(YAML::load(File.open('./app/config/application.yml')))
