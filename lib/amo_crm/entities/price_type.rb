module AmoCRM::Entities
  class PriceType < Base
    include CommonObject
    include AmoCRM::Entities::XmlFix
    tag 'priceType'

    attribute :updated,     Time
    attribute :updatedBy,   String
    attribute :name,        String

    attribute :index,       Integer
  end
end
