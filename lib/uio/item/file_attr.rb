module UIO
  class Item

    attr_accessor :file

    def basename(suffix='')
      file ? File.basename(file, suffix) : nil
    end

    def name
      file ? File.basename(file, '.*') : nil
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
