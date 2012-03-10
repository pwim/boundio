require "json"

module Boundio
  class Client
    def initialize(user_serial_id, api_key)
      @user_serial_id, @api_key = user_serial_id, api_key
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
  end
end
