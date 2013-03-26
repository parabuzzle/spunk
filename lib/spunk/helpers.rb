module Spunk
  module Helpers
   def Helpers.parse_room(command)
     if command.nil?
       return nil
     end
     command.match(/(\#\S+\b)/i)
     return $1
   end
   
   def Helpers.hashify(bot, origin, command, parameters)
     hash = {:bot=>bot, :origin=>origin, :command => command, :msg => parameters, :parameters=>parameters, :room => nil}
     hash[:room] = Helpers.parse_room(command)
     return hash
   end
  end
end