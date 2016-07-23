URLS = HashWithIndifferentAccess.new
URLS.update(YAML::load(File.open('./assets/urls.yml')))
