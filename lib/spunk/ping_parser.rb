module Spunk
  module Processor
    class Ping
      def call(hash)
        if hash[:command] =~ /^PING$/
          hash[:bot].send_message("PONG :#{hash[:parameters]}")
        end
      end
    end
  end
end