module AmoCRM::Entities
  class Contact
    include Virtus.model
    attribute :name, String
    attribute :request_id, Integer
    attribute :date_create, Time
    attribute :last_modified, Time
    attribute :responsible_user_id, Integer
    attribute :linked_leads_id, Array[Integer]
    attribute :tags, Array[String]
    attribute :company_name, String

    attribute :custom_fields, Array[CustomFieldValue]

    def attributes_for_update
      {
        name: name,
        request_id: request_id,
        date_create: date_create.to_i,
        last_modified: last_modified.to_i,
        responsible_user_id: responsible_user_id,
        linked_leads_id: linked_leads_id,
        tags: tags,
        company_name: company_name,
        custom_fields: custom_fields.as_json
      }
    end
  end
end
