module AmoCRM
  module Entities
    extend ActiveSupport::Autoload

    %w{
    Base
    Account
    CustomField
    Company
    }.each do |m|
      autoload m
    end
  end
end
