module Spunk
  module Processor
    class SayHello
      def call(hash)
        # This processor returns "Hello World" for "{bot.nickname} say hello"
        # This processor returns Version for "{bot.nickname} version"
        # {:bot=>bot, :origin=>origin, :command=>command, :msg=>msg, :room=>room}
        
        if hash[:origin].nil?
          # If there is no origin... there is nothing in this
          # parser for for the call. So exit out with a return
          return
        end
        
        # Respond if the bot didn't say it
        unless hash[:origin].nickname == hash[:bot].nickname 
          
          case hash[:msg]
            # Do matching for msg
            when /#{bot.nickname},? say hello$/i
              # if bot.nickname say hello is caught
              bot = hash[:bot]
              room = hash[:room]
              bot.say(room, "Hello World!")
              
            when /#{bot.nickname} version$/i
              # if bot.nickname version is caught
              bot = hash[:bot]
              room = hash[:room]
              bot.say(room, SPUNK_VERSION)
              
          end
        end # End of unless origin.nickname == bot.nickname
      end # end of casll
    end # end SayHello
  end # end Processor
end # end Spunk