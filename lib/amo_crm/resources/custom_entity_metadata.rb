module AmoCRM::Resources
  # https://online.moysklad.ru/exchange/rest/ms/xml/CustomEntityMetadata/list
  # Список аттрибутов, которые используются как свойства товара
  class CustomEntityMetadata < Base
    def self.entity_class
      AmoCRM::Entities::CustomEntityMetadata
    end

    def self.type
      'CustomEntityMetadata'
    end

    def self.resource_name
      :custom_entity_metadata
    end

  end
end
