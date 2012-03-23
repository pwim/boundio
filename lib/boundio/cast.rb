module Boundio
  class Cast
    attr_reader :files

    def initialize(*files)
      @files = files
    end

    def +(file)
      self.class.new(*(files + [file]))
    end

    def to_s
      files.map {|f| "file(#{f.id})" }.join("%%")
    end

    def ==(other)
      other.is_a?(self.class) ? files == other.files : super
    end
  end
end
