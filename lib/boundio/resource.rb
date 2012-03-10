module Boundio
  class Resource
    class << self
      def user_serial_id
        ENV["BOUNDIO_USER_SERIAL_ID"]
      end
      
      def api_key
        ENV["BOUNDIO_API_KEY"]
      end

      def request(method, path, params)
        res = RestClient.send method,
          File.join("https://boundio.jp/api/vd1/#{user_serial_id}", path), 
          params.merge(key: api_key)
        res = JSON.parse(res)
        unless res["success"] == "true"
          raise exceptions[res["error"].to_i] || "Error Code #{res["error"]}"
        end
        res
      end

      def exceptions
        { 1 => Unauthorized }
      end
    end

    def initialize(args)
      args.each {|k,v| send("#{k}=", v) }
    end

    class Unauthorized < StandardError
    end
  end
end
