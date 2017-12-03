module AmoCRM::Resources
  class CatalogElements < Base
    def all
      page.items
    end

    def find
      raise 'no such method'
    end

    def set_path
      'catalog_elements/set'
    end

    def list_path
      'catalog_elements/list'
    end

    def response_key
      'catalog_elements'
    end

    def self.entity_class
      AmoCRM::Entities::CatalogElement
    end

    def self.resource_name
      :catalog_elements
    end
  end
end
