module Boundio
  class TelStatus < Resource
    attr_accessor :id, :from, :to, :start, :end, :duration, :status
    class << self
      def find(id)
        res = request :get, "/tel_status", :tel_id => id
        parse(res["result"].first)
      end

      def find_all(options)
        res = request :get, "/tel_status", options
        res["result"]
      end

      private

      def parse(res)
        new(res.map {|k,v| [k.sub(/^_/, ""), v] })
      end
    end

    def to_s
      "TelStatus (#{id}): #{from} -> #{to}, #{start} - #{self.end}, #{status}"
    end
  end
end
