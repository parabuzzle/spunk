module Spunk
  module Processor
    class Base
      def call(bot, origin, command, parameters)
        if command =~ /^INVITE #{bot.nickname}$/i
          room = Spunk::Helpers.parse_room(parameters)
          if room
            bot.join_room(room)
          end
        end
      end
    end
  end
end