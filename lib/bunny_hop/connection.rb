module BunnyHop
  class Connection
    def initialize(config)
      @config = config
      @connection = Bunny.new(config.options)
    end

    def open
      @connection.start unless @connection.status == :connected
      @connection.qos
    end

    def close
      @connection.stop
    end

    def exchange(exchange_name)
      @connection.exchange(exchange_name, @config.exchanges[exchange_name])
    end

    def queue(queue_name)
      options = @config.queues[queue_name]
      bind = options.delete(:bind)

      queue = @connection.queue(queue_name, options)
      queue.bind(exchange(bind[:exchange]), key: bind[:key]) if bind

      queue
    end
  end
end
