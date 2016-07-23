URLS = HashWithIndifferentAccess.new
URLS.update(YAML::load(File.open('./app/assets/urls.yml')))
