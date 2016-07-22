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
    end
  end
end
