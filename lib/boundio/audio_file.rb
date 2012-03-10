module Boundio
  class AudioFile < Resource
    attr_accessor :conv_text, :filename, :id

    def self.exceptions
      super.merge(2 => ArgumentError.new("insufficient parameters or file to big"))
    end

    def save
      res = request :post, "/file/post", :conv_text => conv_text, :filename => file_name
      self.id = res["fileid"]
      true
    end
  end
end
