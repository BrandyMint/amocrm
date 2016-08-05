require 'hashie'

module AmoCRM
  class Universe

    cattr_reader :resources_list
    attr_reader :client

    # @param client[AmoCRM::Client]
    def initialize client: nil
      raise "Должен быть client[AmoCRM::Client]" unless client.is_a? AmoCRM::Client
      @client = client
      @resources={}
    end

    def self.client_class
      Client
    end

    # Ленивое создание universe
    #
    # @param user_login
    # @param user_hash
    def self.build user_login: , user_hash: , url:
      client = client_class.new url: url
      client.authorize! user_login: user_login, user_hash: user_hash
      new client: client
    end

    @@resources_list = []
    AmoCRM::Resources.resources.each do |resource_klass|
      resource = resource_klass.resource_name.to_sym
      fail "Already have such resource #{resource}" if @@resources_list.include? resource
      @@resources_list << resource
      define_method resource_klass.resource_name do
        @resources[resource_klass.type] ||= resource_klass.indexed( client: client )
      end
    end

    def class_by_resource resource
      "AmoCRM::Resources::#{resource.to_s.singularize.capitalize}".constantize
    end
  end
end
