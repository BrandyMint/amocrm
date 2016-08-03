module AmoCRM
  class Response
    include Virtus.model
    attribute :response
    attribute :server_time, Integer
  end
end
