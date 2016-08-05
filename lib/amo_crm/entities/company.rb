module AmoCRM::Entities
  class Company
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

    def to_s
      as_json.to_s
    end

    def attributes_for_update
      {
        id: id,
        last_modified: last_modified,
        request_id: request_id,
        name: name,
        company_name: company_name,
        custom_fields: custom_fields
      }
    end
  end
end
