module AmoCRM::Resources
  class Leads < Base
    def all
      page.items
    end

    def find
      raise 'no such method'
    end

    def set_path
      'leads/set'
    end

    def list_path
      'leads/list'
    end

    def response_key
      'leads'
    end

    def self.entity_class
      AmoCRM::Entities::Lead
    end

    def self.resource_name
      :companies
    end
  end
end
