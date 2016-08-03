module AmoCRM::Entities
  # https://online.moysklad.ru/exchange/rest/ms/xml/MyCompany/list
  class MyCompany < Base
    include AmoCRM::Entities::CompanyConcern

    tag 'myCompany'

    attribute :director,    String
    attribute :chiefAccountant, String

  end
end
