module AmoCRM::Resources
  class Contacts < Base
    def all
      page.items
    end

    def set_path
      'contacts/set'
    end

    def list_path
      'contacts/list'
    end

    def response_key
      'contacts'
    end

    def self.entity_class
      AmoCRM::Entities::Contact
    end

    def self.resource_name
      :contacts
    end
  end
end
