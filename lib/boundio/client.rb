require "json"

module Boundio
  class Client
    def initialize(user_serial_id, api_key)
      @user_serial_id, @api_key = user_serial_id, api_key
    end

    def call(tel_to, cast)
      res = RestClient.post "https://boundio.jp/api/vd1/#{@user_serial_id}/call", 
        :key => @api_key, :tel_to => tel_to, :cast => cast
      res = JSON.parse(res)
      exception(res)
      res["_id"]
    end
    
    private

    def exception(res)
      unless res["success"] == "true"
        raise "Error Code #{res["error"]}"
      end
    end
  end
end
