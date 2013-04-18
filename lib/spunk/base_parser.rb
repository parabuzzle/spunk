module Spunk
  module Processor
    class Base
      def call(hash)
        bot = hash[:bot]
        command = hash[:command]
        parameters = hash[:parameters]
        origin = hash[:origin]
        
        if command =~ /^INVITE #{bot.nickname}$/i
          room = Helpers.parse_room(hash[:parameters])
          hash[:logger].debug "Recieved invite for room #{room}"
          if bot.invite_ok == true
            if room
              bot.join_room(room)
              hash[:logger].debug "Joined #{room}"
            end
          else
            hash[:logger].error "Invite support is turned off... can't be invited to a room"
          end
        end
        if command =~ /^KICK (#\S+)\W(.*)\W?/
          # Remove from array of joined_rooms when kicked
          nick = $2
          if bot.nickname == nick
            room = [$1]
            bot.joined_rooms -= room
          end
        end
      end
    end
  end
end