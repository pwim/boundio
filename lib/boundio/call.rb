module Boundio
  class Call < Resource
    attr_accessor :tel_to, :cast, :id
    def save
      res = self.class.request :post, "/call", tel_to: tel_to, cast: cast
      self.id = res["_id"]
      true
    end
  end
end
