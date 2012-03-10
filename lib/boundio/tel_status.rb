module Boundio
  class TelStatus < Resource
    def self.find(id)
      res = request :get, "/tel_status", :tel_id => id
      res["_result"]
    end

    def self.find_all(options)
      res = request :get, "/tel_status", options
      res["_result"]
    end
  end
end
