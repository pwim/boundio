module Boundio
  class Resource
    class << self
      def api_version
        "vd1"
      end

      %w[user_serial_id api_key user_key].each do |s|
        var = "BOUNDIO_#{s.upcase}"
        define_method(s) do
          ENV[var] || raise("Please export #{var}")
        end
      end

      def request(method, path, params)
        params = params.merge(:key => api_key, :auth => user_key)
        res = RestClient.send method,
          File.join("https://boundio.jp/api/", api_version, user_serial_id, path), 
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
