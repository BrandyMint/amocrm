module AmoCRM::Resources
  class Catalogs < Base
    def all
      page.items
    end

    def find
      raise 'no such method'
    end

    def set_path
      'catalogs/set'
    end

    def list_path
      'catalogs/list'
    end

    def response_key
      'catalogs'
    end

    def self.entity_class
      AmoCRM::Entities::Catalog
    end

    def self.resource_name
      :catalogs
    end
  end
end
