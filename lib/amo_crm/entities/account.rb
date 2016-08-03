module AmoCRM::Entities
  class Account < Base
    def self.parse(response)
      new response
    end
  end
end
