module RealmStatus
  REGEX = /^(?:!realm)/i

  class << self
    def function(event)
      path = BattleNet.path_builder(:REALMSTATUS)
      ApiConnector.get(path)
    end

    def regex
      RealmStatus::REGEX
    end
  end
end
