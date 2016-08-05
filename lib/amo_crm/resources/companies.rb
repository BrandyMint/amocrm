module AmoCRM::Resources
  class Companies < Base
    def find
      raise 'no such method'
    end

    def set_path
      'company/set'
    end

    def list_path
      'company/list'
    end

    def response_key
      'contacts'
    end

    def self.entity_class
      AmoCRM::Entities::Company
    end

    def self.resource_name
      :companies
    end
  end
end
