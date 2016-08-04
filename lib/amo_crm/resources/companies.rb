module AmoCRM::Resources
  class Companies < Base
    LIMIT_ROWS = 500

    def all
      companies = []
      offset = 0
      list = nil

      while offset==0 || list.present?
        list = client.get('company/list', limit_offset: offset, limit_rows: LIMIT_ROWS).contacts
        offset += LIMIT_ROWS
        companies += list
      end

    rescue AmoCRM::Client::Error => err
      raise err unless err.state == 204
      companies
    end

    def find
      raise 'no such method'
    end

    def set_path
      'company/set'
    end

    def list_path
      'company/list'
    end

    def response_key
      'contacts'
    end

    def self.entity_class
      AmoCRM::Entities::Company
    end

    def self.resource_name
      :companies
    end
  end
end
