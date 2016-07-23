BOT_ENV = HashWithIndifferentAccess.new
BOT_ENV.update(YAML::load(File.open('./config/application.yml')))
