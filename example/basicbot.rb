# an example script to run a Spunk bot

require_relative '../lib/spunk'                     # load the local version
require_relative './parsers/say_hello'              # load simple command parser
require_relative './parsers/spit_out_to_console'    # load a console logger

options = { :nickname => "spunk",
            :username => "spunk",
            :ssl => false,
            :token => nil,
            :hostname => "localhost",
            :port => nil,
            :rooms => ["#spunk"]}

@bot = Spunk::Bot.new options

def self_contained_run
  # Simple way of starting your bot
  @bot.add_processor Spunk::Processor::SayHello.new
  @bot.add_processor LogToConsole.new
  @bot.run
end

def expanded_run
  # Expanded way of starting your bot
  @bot.connect
  @bot.authenticate
  @bot.add_processor Spunk::Processor::SayHello.new
  @bot.add_processor LogToConsole.new
  @bot.join_room "#test-spunk"
  @bot.start
end

# Start the bot
self_contained_run
  
