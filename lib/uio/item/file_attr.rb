module UIO
  class Item

    attr_reader :file

    def basename
      file ? File.basename(file, extname) : nil
    end

    def extname
      file ? File.extname(file) : nil
    end

    def dirname
      file ? File.dirname(file) : nil
    end

    def expand_path
      file ? File.expand_path(file) : nil
    end

  end
end
