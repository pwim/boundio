require "test_helper"

class TestAudioFile < BoundioTest
  def test_create
    stub_request(:post, "https://boundio.jp/api/v1/user_serial_id/file/post").
      with(:body => {"auth"=>"user_authentication_key", "convtext"=>"foo", "filename"=>"foo", "key"=>"api_key"}).to_return(:body => {:success => "true", :fileid => 5}.to_json)
    file = Boundio::AudioFile.new(:convtext => "foo")
    file.save
    assert_equal 5, file.id
  end

  def test_combining_files
    f1 = Boundio::AudioFile.new
    f2 = Boundio::AudioFile.new
    cast = f1 + f2
    assert_instance_of Boundio::Cast, cast
    assert_equal [f1, f2], cast.instance_variable_get(:@files)
  end
end
