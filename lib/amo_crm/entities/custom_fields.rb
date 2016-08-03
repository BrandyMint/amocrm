require 'hashie'

module AmoCRM
  class CustomFields < Hashie::Mash
    def as_json
      map do |id, value|
        values = Array(value).map { |value|
          if value.is_a? Hash
            value.map do |k, v|
              {
                value: v,
                enum: k,
              }
            end
          else
            { value: value }
          end
        }.flatten

        { id: id, values: values }
      end
    end
  end
end
