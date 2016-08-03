module AmoCRM::Resources
  class Account < Base

    def current
      get
    end

    def get
      parse client.get 'accounts/current'
    end

    def self.entity_class
      AmoCRM::Entities::Account
    end

    def response_key
      'account'
    end

    def self.resource_name
      :account
    end

    private

    def parse data
      self.class.entity_class.new data[response_key]
    end
  end
end
