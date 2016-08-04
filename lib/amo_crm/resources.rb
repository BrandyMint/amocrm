module AmoCRM::Resources
  mattr_accessor :resources

  extend ActiveSupport::Autoload

  def self.register_resource resource_class
    self.resources ||= []
    self.resources << resource_class
  end

  require_relative 'resources/base'
  require_relative 'resources/indexed'
  require_relative 'resources/companies'
  require_relative 'resources/leads'
  require_relative 'resources/contacts'
  require_relative 'resources/account'
  require_relative 'resources/custom_field'
end
