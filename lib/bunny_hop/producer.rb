module BunnyHop
  class Producer
    DEFAULT_MESSAGE_OPTIONS = { content_type: 'application/json', mandatory: false, immediate: false, persistent: true }

    def initialize(exchange_name)
      @exchange_name = exchange_name
    end

    def exchange
      @exchange ||= BunnyHop.connection.exchange(@exchange_name)
    end

    def publish(message, options={})
      message = JSON.dump(message)
      BunnyHop.logger.info("Publishing to #{@exchange_name.empty? ? 'DEFAULT' : @exchange_name} exchange :: #{message}")
      exchange.publish(message, DEFAULT_MESSAGE_OPTIONS.merge(options))
    end
  end
end
