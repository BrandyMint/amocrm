class AmoCRM::Client
  class Error < StandardError
    attr_reader :message, :state

    def initialize state, message
      @state = state
      @message = message
    end

    def to_s
      "#{state}: #{message}"
    end
  end
end
