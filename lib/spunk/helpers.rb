module Spunk
  module Helpers
   def Helpers.parse_room(command)
     command.match(/(\#\S+\b)/i)
     return $1
   end
   
   def Helpers.hashify(bot, origin, command, msg)
     hash = {:bot=>bot, :origin=>origin, :command => command, :msg => msg, :room => nil}
     hash[:room] = Helpers.parse_room(command)
     return hash
   end
  end
end