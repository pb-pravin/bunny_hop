module BunnyHop
  class Config
    DEFAULT_EXCHANGE_CONFIG = { type: :direct, auto_delete: false, durable: true }
    DEFAULT_QUEUE_CONFIG = { auto_delete: false, durable: true }

    attr_accessor :options
    attr_reader :exchanges, :queues
    attr_writer :logger, :log_formatter

    def initialize
      @options, @exchanges, @queues = {}, {}, {}

      @logger = Logger.new(STDOUT)
      @log_formatter = Proc.new do |severity, datetime, progname, msg|
        "[#{datetime}] #{severity} -- : #{msg}\n"
      end
    end

    def exchange(name, options={})
      @exchanges[name] = DEFAULT_EXCHANGE_CONFIG.merge(options)
    end

    def logger
      @logger.formatter = @log_formatter
      @logger
    end

    def queue(name, options={})
      @queues[name] = DEFAULT_QUEUE_CONFIG.merge(options)
    end
  end
end
