module AmoCRM::Entities
  class CustomerOrderPosition < Base
    include HappyMapper
    include XmlFix

    tag 'customerOrderPosition'

    attribute :vat,       Integer
    attribute :goodUuid,  String
    attribute :consignmentUuid, String
    attribute :quantity,  Float
    attribute :discount,  Float
    attribute :consignmentUuid, String

    element :deleted,   Time

    element :basePrice, AmoCRM::Entities::Price, tag: :basePrice
    element :price,     AmoCRM::Entities::Price, tag: :price
    element :reserve,   Float
  end

end
