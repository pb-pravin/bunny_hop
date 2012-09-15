require 'bunny'
require 'logger'
require 'json'
require 'bunny_hop/config'
require 'bunny_hop/connection'
require 'bunny_hop/consumer'
require 'bunny_hop/producer'
require "bunny_hop/version"
require 'bunny_hop/worker'

module BunnyHop
  class << self
    def connection
      @connection ||= Connection.new(config)
    end

    def config
      @config ||= Config.new
    end

    def configure
      yield config
    end

    def logger
      config.logger
    end

    def pop(queue_name, options={})
      consumer = Consumer.new(queue_name, MessageHandlers::ReturnHandler.new)
      consumer.pop(options)
    end

    def publish(exchange_name, message, options={})
      producer = Producer.new(exchange_name)
      producer.publish(message, options)
    end

    def subscribe(queue_name)
      consumer = Consumer.new(queue_name, MessageHandlers::ReturnHandler.new)
      consumer.subscribe do |metadata, payload|
        yield [metadata, payload]
      end
    end

    def start
      connection.open
    end

    def stop
      connection.close
    end
  end
end
