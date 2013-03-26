class LogToConsole
  def call(hash)
    # This processor spits out all calls to STDOUT

    puts "#{hash[:origin]} :: #{hash[:command]} :: #{hash[:msg]} :: #{hash[:room]}"
    
  end
end