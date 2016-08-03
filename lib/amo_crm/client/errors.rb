require_relative 'error'

class AmoCRM::Client
  class Errors
    def self.build res
      body = JSON.parse res.body
      AmoCRM.logger.warn "AmoCRM::Client: #{res.status}: #{res.env.url.to_s}\n#{body}"
      raise Error.new body['response']
    end
  end
end

