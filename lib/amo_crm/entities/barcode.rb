module AmoCRM::Entities
  class Barcode < Base
    include HappyMapper
    include AmoCRM::Entities::XmlFix

    tag 'barcode'

    attribute :barcode,     String
    attribute :barcodeType, String

    attribute :accountUuid, String
    attribute :accountId,   String
    attribute :uuid,        String
    attribute :groupUuid,   String
    attribute :ownerUuid,   String

    attribute :shared,      Boolean
  end
end
