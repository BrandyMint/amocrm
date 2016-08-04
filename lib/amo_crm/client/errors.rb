require_relative 'error'

class AmoCRM::Client
  class Errors
    def self.build res
      body = res.body.present? ? JSON.parse(res.body) : {}
      AmoCRM.logger.warn "AmoCRM::Client: #{res.status}: #{res.env.url.to_s}\n#{body}"
      raise Error.new res.status, body['response']
    end
  end
end
