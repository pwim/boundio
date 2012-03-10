require "json"

module Boundio
  class Client
    def initialize(user_serial_id, api_key)
      @user_serial_id, @api_key = user_serial_id, api_key
    end

    def call(tel_to, cast)
      res = request :post, "/call", tel_to: tel_to, cast: cast
      unless res["success"] == "true"
        raise "Error Code #{res["error"]}"
      end
      res["_id"]
    end
    
    def status(args)
      res = request :get, "/tel_status", args
      unless res["success"] == "true"
        raise "Error Code #{res["error"]}"
      end
      res["_result"]
    end

    def file(args)
      res = request :post, "/file/post", args
      unless res["success"] == "true"
        raise case res["error"].to_i
        when 2
          ArgumentError.new("insufficient parameters or file to big")
        else
          "Error Code #{res["error"]}"
        end
      end
      res["fileid"]
    end

    private

    def request(method, path, params)
      res = RestClient.send method,
        File.join("https://boundio.jp/api/vd1/#{@user_serial_id}", path), 
        params.merge(key: @api_key)
      JSON.parse(res)
    end
  end
end
