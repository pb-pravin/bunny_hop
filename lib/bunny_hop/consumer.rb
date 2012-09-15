require 'bunny_hop/message_handlers/null_handler'
require 'bunny_hop/message_handlers/return_handler'

module BunnyHop
  class Consumer
    def initialize(queue_name, message_handler)
      @queue_name = queue_name
      @message_handler = message_handler
    end

    def pop(options={})
      handle_message(queue.pop)
    end

    def queue
      @queue ||= BunnyHop.connection.queue(@queue_name)
    end

    def subscribe
      BunnyHop.logger.info("Subscribing to #{@queue_name} queue")
      queue.subscribe(ack: true) do |message|
        if block_given?
          yield handle_message(message)
        else
          handle_message(message)
        end
      end
    end

    def unsubscribe
      BunnyHop.logger.info("Unsubscribing from #{@queue_name} queue")
      queue.unsubscribe
    end

    private
    def handle_message(message)
      metadata, payload = parse_message(message)
      BunnyHop.logger.info("Receiving message from #{@queue_name} queue :: #{payload}")
      @message_handler.call(metadata, JSON.load(payload))
    rescue => error
      BunnyHop.logger.error("#{error.class}: #{error.message}\n#{error.backtrace.join("\n")}")
    end

    def parse_message(message)
      payload = message.delete(:payload)
      [message, payload]
    end
  end
end
