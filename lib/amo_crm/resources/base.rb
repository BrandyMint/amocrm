module AmoCRM::Resources
  class Base
    LIMIT_ROWS = 500

    def self.inherited superclass
      super
      AmoCRM::Resources.register_resource superclass
    end

    # Возвращает этот-же ресурс только индексированный
    #
    # @return [AmoCRM::Resources::Indexed]
    def self.indexed *args
      # AmoCRM::Resources::Indexed.new new(*args)
      new(*args)
    end

    def initialize client: nil
      raise "Должен быть AmoCRM::Client" unless client.is_a? AmoCRM::Client
      @client = client
    end

    def all
      buffer = []
      offset = 0
      list = nil

      while offset==0 || list.present?
        list = client.get(list_path, limit_offset: offset, limit_rows: LIMIT_ROWS).contacts
        offset += LIMIT_ROWS
        buffer += list
      end

    rescue AmoCRM::Client::Error => err
      raise err unless err.state == 204
      buffer
    end

    # Возвращает список элементов как есть
    #
    # @return [Array of AmoCRM::Entities::Base]
    def list params={}
      parse_list client.get list_path, params
    end

    # Возвращает страницу со списком элементов
    #
    # @return [AmoCRM::Entities::Page]
    def page params={}
      parse_page client.get list_path, params
    end

    # Забираем элемент по id
    #
    # @return [AmoCRM::Entities::Base]
    def get id=nil
      parse client.get get_path, id: id
    end

    # Модифицируем элемент по id
    #
    # @return [AmoCRM::Entities::Base]
    def update model
      raise "Должна быть модель типа AmoCRM::Entities::Base" unless model.is_a? AmoCRM::Entities::Base
      client.post set_path, model_to_request(model)
    end

    # Создаем запись
    #
    # @param [AmoCRM::Entities::Base]
    #
    # Возвращается созданная на сервере сущность
    #
    # @return [AmoCRM::Entities::Base]
    def create model
      raise "Должна быть модель типа AmoCRM::Entities::Base" unless model.is_a? AmoCRM::Entities::Base
      client.post set_path, model_to_request(model, :add)
    end

    # Удаляем запись по id
    #
    # @param id
    def delete id
      client.delete get_path id
    end

    def self.type
      ActiveSupport::Inflector.singularize name.split('::').last.to_sym
    end

    def self.resource_name
      ActiveSupport::Inflector.underscore ActiveSupport::Inflector.pluralize type
    end

    def self.entity_class
      ActiveSupport::Inflector.constantize "AmoCRM::Entities::#{type.to_s}"
    end

    private

    attr_reader :client

    def model_to_request(model, command=:update)
      {
        request: {
          response_key => {
            command => [model.attributes_for_update]
          }
        }
      }
    end

    def parse data
      self.class.entity_class.new data[response_key].first
    end

    def parse_list content
      content[response_key].map do |data|
        self.class.entity_class.new data
      end
    end

    def parse_content content
      content
    end

    def parse_page content
      col = AmoCRM::Entities::Collection.parse parse_content content

      # TODO Парсится два раза. Оптимизировать. Например сделать динамические CollectionFeature
      # и парсить через них

      items = parse content
      AmoCRM::Entities::Page.new items, col.total,  col.start, col.count
    end

    def get_path
      list_path
    end

    def set_path
      raise 'not implemented'
    end

    def list_path
      raise 'not implemented'
    end
  end
end
