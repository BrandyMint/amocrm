require_relative 'error'

class AmoCRM::Client
  class Errors
    def self.build res
      if res.try(:body).present?
        AmoCRM.logger.error "AmoCRM::Client: #{res.class} #{res.headers['Content-Type']} #{res.status}: #{res.env.url.to_s}\n#{res.body}"
        body = JSON.parse(res.body) rescue { 'response' => body }
        raise Error.new res.status, body['response']
      else
        AmoCRM.logger.error "AmoCRM::Client: #{res.class} #{res}"
        raise Error.new 999, res.to_json
      end
    end
  end
end
