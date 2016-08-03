module AmoCRM::Resources
  class Stock < Base

    def listWithConsignments params={}
      list params.merge(showConsignments: true)
    end

    def all
      page.items
    end

    def find
      raise 'no such method'
    end

    def list_path
      'exchange/rest/stock/xml'
    end

    def self.entity_class
      AmoCRM::Entities::StockTO
    end

    def self.resource_name
      :stock
    end

    private

    def parse_page content
      items = AmoCRM::Entities::StockTO.parse content
      AmoCRM::Entities::Page.new items, items.count, 0, items.count
    end

  end
end
