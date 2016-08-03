module AmoCRM::Entities
  # https://online.moysklad.ru/exchange/rest/ms/xml/Warehouse/list
  class Slot < Base
    include HappyMapper
    include AmoCRM::Entities::XmlFix

    tag 'slot'

  end
end
