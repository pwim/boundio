# encoding: UTF-8
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
        res["result"].map {|h| parse(h)}
      end

      private

      def parse(res)
        new(res.map {|k,v| [k.sub(/^_/, ""), v] })
      end
    end

    def processing?
      status == "架電待機"
    end

    def to_s
      "TelStatus (#{id}): #{from} -> #{to}, #{start} - #{self.end}, #{status}"
    end
  end
end
