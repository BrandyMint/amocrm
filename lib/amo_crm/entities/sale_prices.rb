module AmoCRM::Entities
  class SalePrices < Base
    include HappyMapper
    include AmoCRM::Entities::XmlFix

    tag 'salePrices'

    has_many :price, AmoCRM::Entities::SalePrice
  end
end
