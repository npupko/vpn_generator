module Templates
  class GeneratedKey
    include Import['key_generator']

    def text
      "Your key is: #{key}"
    end

    def key
      key_generator.call.key
    end

    def reply_markup
      nil
    end
  end
end
