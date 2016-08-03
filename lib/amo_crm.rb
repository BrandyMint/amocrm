require 'happymapper'
require 'active_support'
require 'active_model'
ActiveModel::Serializers::JSON
require "amo_crm/version"

require 'logger'

module AmoCRM
  mattr_accessor :custom_logger
  extend ActiveSupport::Autoload

  autoload :Entities
  autoload :Resources
  autoload :Client
  autoload :Universe

  def self.logger= value
    self.custom_logger = value
  end

  def self.logger
    return custom_logger if custom_logger

    if defined? Rails
      Rails.logger
    else
      Logger.new STDERR
    end
  end
end
