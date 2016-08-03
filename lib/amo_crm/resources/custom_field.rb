module AmoCRM::Resources
  class CustomField < Base

    def all
      page.items
    end

    def find
      raise 'no such method'
    end

    def list_path
      'accounts/current'
    end

    def pluralized_key_path
      'account' # custom_fields
    end

    def self.entity_class
      AmoCRM::Entities::CustomField
    end

    def self.resource_name
      :custom_fields
    end
  end
end
