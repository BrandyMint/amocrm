module AmoCRM::Resources
  class EmbeddedEntityMetadata < Base
    def self.entity_class
      AmoCRM::Entities::EmbeddedEntityMetadata
    end

    def self.type
      'EmbeddedEntityMetadata'
    end

    def self.resource_name
      :embedded_entity_metadata
    end

    def self.indexed *args
      AmoCRM::Resources::EmbeddedEntityMetadataIndexed.new new(*args)
    end

  end
end
