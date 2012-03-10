module Boundio
  class Call < Resource
    attr_accessor :tel_to, :cast, :id
    def self.exceptions
      super.merge(4 => NotEnoughPoints)
    end

    def save
      res = self.class.request :post, "/call", tel_to: tel_to, cast: cast
      self.id = res["_id"]
      true
    end

    class NotEnoughPoints < Boundio::Exception
    end
  end
end
