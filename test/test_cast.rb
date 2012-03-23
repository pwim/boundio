require "test_helper"

class TestCast < BoundioTest
  def test_combining
    f1 = Boundio::AudioFile.new(:id => '000001')
    f2 = Boundio::AudioFile.new(:id => '000002')
    cast = Boundio::Cast.new(f1)
    assert_equal Boundio::Cast.new(f1,f2), cast + f2
  end
  def test_to_s
    f1 = Boundio::AudioFile.new(:id => '000001')
    f2 = Boundio::AudioFile.new(:id => '000002')
    cast = Boundio::Cast.new(f1, f2)
    assert_equal 'file(000001)%%file(000002)', cast.to_s
  end
end
