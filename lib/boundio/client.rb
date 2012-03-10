require "json"

module Boundio
  class Client
    def initialize(user_serial_id, api_key)
      @user_serial_id, @api_key = user_serial_id, api_key
    end

    def call(tel_to, cast)
      res = request :post, "/call", tel_to: tel_to, cast: cast
      res["_id"]
    end
    
    def status(args)
      res = request :get, "/tel_status", args
      res["_result"]
    end

    private

    def request(method, path, params)
      res = RestClient.send method,
        File.join("https://boundio.jp/api/vd1/#{@user_serial_id}", path), 
        params.merge(key: @api_key)
      res = JSON.parse(res)
      unless res["success"] == "true"
        raise "Error Code #{res["error"]}"
      end
      res
    end
  end
end
