module AmoCRM::Entities
  class Lead
    include Virtus.model
    attribute :name, String
    attribute :date_create, Time
    attribute :last_modified, Time
    attribute :status_id, Integer
    attribute :price, Integer
    attribute :request_id, Integer
    attribute :tags, Array[String]
    # responsible_user_id


    def attributes_for_update
      {
        name: name,
        date_create: date_create.to_i,
        last_modified: last_modified.to_i,
        request_id: request_id,
        # status_id: status_id,
        price: price,
        custom_fields: custom_fields,
        # tags: tags,
        visitor_uid: visitor_uid,
      }
    end
  end
end
