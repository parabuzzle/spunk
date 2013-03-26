Spunk
=======

IrcBot Framework based on Sprinkles.

1. Install the Gem

        gem install spunk

2. load library and setup your options

		require 'spunk'
		options = { :nickname => "spunk",
		            :username => "spunk",
		            :hostname => "localhost",
		            :rooms => ["#spunk"]}

3. setup your bot

		@bot = Spunk::Bot.new options
		
4. add your processors

		@bot.add_processor Spunk::Processor::SayHello.new
		@bot.add_processor LogToConsole.new
		
5. start your bot

		@bot.run

See example folder for examples of processors and usage.
