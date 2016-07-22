module DbConnector
  class << self
    def select(query)
      @db.exec(query) do |result|
        #stuff
      end
    end
  end
end
