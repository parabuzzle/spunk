class TestBot < Test::Unit::TestCase
  
  def setup
    options = { :nickname => "testnick",
                :rooms => ["#test-room"],
                :ssl => true,
                :token => "1234",
                :hostname => "serverhost",
                :port => 6697,
                :random => "randomvar"}
    @bot = Spunk::Bot.new(options)
    @defaultbot = Spunk::Bot.new
  end
  
  def test_options_parsing
    assert_match @bot.token, "1234"
    assert @bot.ssl
    assert_equal @bot.server[:port], 6697
    assert_match @bot.hostname, Socket.gethostname
    assert_match @bot.server[:hostname], "serverhost"
    assert_match @bot.rooms.first, "#test-room"
  end
  
  def test_default_options
    assert_nil @defaultbot.token
    assert !@defaultbot.ssl
    assert_match @defaultbot.server[:hostname], "localhost"
    assert_equal @defaultbot.server[:port], 6667
    assert_nil @defaultbot.rooms.first
  end
  
end
