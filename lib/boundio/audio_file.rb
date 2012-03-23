module Boundio
  class AudioFile < Resource
    attr_accessor :convtext, :id, :file

    def self.api_version
      "v1"
    end

    def self.exceptions
      super.merge(2 => InsufficientParametersOrTooBigFile, 6 => VoiceConversionError)
    end

    def save
      args = if file
        { :file => file, :filename => File.basename(file.path) }
      else
        { :convtext => convtext, :filename => convtext }
      end
      res = self.class.request :post, "/file/post", args
      self.id = res["fileid"]
      true
    end

    class InsufficientParametersOrTooBigFile < Boundio::Exception; end
    class VoiceConversionError < Boundio::Exception; end
  end
end
