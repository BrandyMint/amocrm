class AmoCRM::Client
  class Error < StandardError
    attr_reader :state, :body

    def initialize state, body
      @state = state
      @body = body
    end

    def message
      to_s
    end

    def to_s
      "#{state}: #{body}"
    end
  end
end
