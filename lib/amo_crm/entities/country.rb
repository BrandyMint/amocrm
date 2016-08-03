module AmoCRM::Entities
  class Country < Base
    include CommonObject
    include AmoCRM::Entities::XmlFix

    tag 'country'

    element   :code,              String
  end
end
