module BotInstall
  class << self
    def install
      install_gems
    end

    private
    def install_gems
      GemInstall.install_gem_library(false)
    end

    def setup_db
      `createdb #{DB['default']['database']}`
        # load schema
    end
  end
end
