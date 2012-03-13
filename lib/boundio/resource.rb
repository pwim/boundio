module Boundio
  class Resource
    class << self
      def user_serial_id
        ENV["BOUNDIO_USER_SERIAL_ID"]
      end
      
      def api_key
        ENV["BOUNDIO_API_KEY"]
      end

      def user_authentication_key
        ENV["BOUNDIO_USER_AUTHENTICATION_KEY"]
      end

      def request(method, path, params)
        params = params.merge(:key => api_key, :auth => user_authentication_key)
        res = RestClient.send method,
          File.join("https://boundio.jp/api/vd1/#{user_serial_id}", path), 
          method == :get ? { :params => params } : params
        res = JSON.parse(res)
        res = res.first if res.is_a?(Array)
        unless res["success"] == "true"
          raise exceptions[res["error"].to_i] || Boundio::Exception.new("Error Code #{res["error"]}")
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

    class Unauthorized < Boundio::Exception
    end
  end
end
