class AmoCRM::Client
  class Error < StandardError
    attr_reader :message

    def initialize mess
      @message = mess
    end

    def to_s
      message['error']
    end
  end
end
