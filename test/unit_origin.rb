class TestOrigin < Test::Unit::TestCase
  
  def setup
    @o = Spunk::Origin.new("heijmans")
    @no_o = Spunk::Origin.new("")
  end
  
  def test_nickname
    assert_match @o.nickname, "heijmans"
    assert_nil @no_o.nickname
  end
  
  def test_to_s
    assert_match @o.to_s, "heijmans"
    assert_nil @no_o.to_s
  end
  
end