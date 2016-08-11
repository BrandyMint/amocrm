require_relative 'error'

class AmoCRM::Client
  class Errors
    def self.build res

      if res.try(:body).present?
        body = JSON.parse(res.body)
        AmoCRM.logger.error "AmoCRM::Client: #{res.class} #{res.status}: #{res.env.url.to_s}\n#{body}"
        raise Error.new res.status, body['response']
      else
        AmoCRM.logger.error "AmoCRM::Client: #{res}"
        raise Error.new 999, res.to_json
      end
    end
  end
end
