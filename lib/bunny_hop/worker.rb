module BunnyHop
  class Worker
    def initialize(consumer)
      @consumer = consumer
    end

    def start
      trap("TERM") { stop; exit }
      trap("INT")  { stop; exit }

      BunnyHop.logger.info "Starting BunnyHop worker..."
      BunnyHop.start # most likely already started
      @consumer.subscribe
    end

    def stop
      BunnyHop.logger.info "Stopping BunnyHop worker..."
      @consumer.unsubscribe
      BunnyHop.stop
    end
  end
end
