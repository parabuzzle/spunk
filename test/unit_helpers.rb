class TestHelpers < Test::Unit::TestCase
  def setup
    @hash = Spunk::Helpers.hashify("bot", "origin", "#test-room command", "msg", "logger")
  end
  
  def test_parse_room
    assert_match Spunk::Helpers.parse_room("#test-room"), "#test-room"
    assert_match Spunk::Helpers.parse_room("#test-room extra data"), "#test-room"
  end
  
  def test_hashify
    assert_match @hash[:bot], "bot"
    assert_match @hash[:origin], "origin"
    assert_match @hash[:command], "#test-room command"
    assert_match @hash[:msg], "msg"
    assert_match @hash[:room], "#test-room"
    assert_match @hash[:logger], "logger"
  end  
  
end
