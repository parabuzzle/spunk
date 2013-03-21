class LogToConsole
  def call(bot, origin, command, parameters)
    # This processor spits out all calls to STDOUT
    
    # Create a useful hash using the hashify helper
    # hashify will take the call params and return a hash of:
    # {:bot=>bot, :origin=>origin, :command=>command, :msg=>msg, :room=>room}
    hash = Spunk::Helpers.hashify(bot, origin, command, parameters)
    puts "#{hash[:origin]} :: #{hash[:command]} :: #{hash[:msg]} :: #{hash[:room]}"
    
  end
end