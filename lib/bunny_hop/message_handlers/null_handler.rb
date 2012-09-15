module BunnyHop
  module MessageHandlers
    class NullHandler
      def call(metadata, payload)
        # Do nothing
      end
    end
  end
end
