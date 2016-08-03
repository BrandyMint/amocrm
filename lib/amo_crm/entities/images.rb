module AmoCRM::Entities
  class Images < Base
    include HappyMapper
    include AmoCRM::Entities::XmlFix

    tag 'images'

    has_many :image, AmoCRM::Entities::Image
  end
end
