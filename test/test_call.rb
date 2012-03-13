require "test_helper"

class TestCall < BoundioTest
  def test_create_new_call
    stub_request(:post, "https://boundio.jp/api/vd1/user_serial_id/call").
      with(:body => {"auth"=>"user_authentication_key", "cast"=>"file(0001)", "key"=>"api_key", "tel_to"=>"09012345678"}).to_return(:body => {:success => "true", :_id => 5}.to_json)
    call = Boundio::Call.new(:tel_to => "09012345678", :cast => "file(0001)")
    call.save
    assert_equal 5, call.id
  end
end
