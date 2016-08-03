module AmoCRM::Entities
  class CustomField < Base
    attribute :id, Integer
    attribute :name, String
    attribute :code, String # PHONE, EMAIL, WEB, ADDRESS
    attribute :multiple, String # Y/N
    attribute :type_id, Integer
    attribute :disabled, Integer # 0/1
    attribute :sort, Integer
    attribute :enums, Hash # {"450999"=>"WORK", "451001"=>"WORKDD", "451003"=>"MOB", "451005"=>"FAX", "451007"=>"HOME", "451009"=>"OTHER"}}
    attribute :values, Array[CustomFieldValue]
  end
end
