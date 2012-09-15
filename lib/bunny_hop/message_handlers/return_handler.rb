module BunnyHop
  module MessageHandlers
    class ReturnHandler
      def call(metadata, payload)
        return [metadata, payload]
      end
    end
  end
end

