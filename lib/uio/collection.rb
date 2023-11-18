module UIO

  class << self

    def collection
      Collection.new
    end

    def glob(pattern)
      Collection.glob pattern
    end

  end


  class Collection < Array

    class << self

      def glob(pattern)
        new glob: pattern
      end

    end


    def initialize(glob: nil)
      self.glob glob if glob
    end

    def glob(pattern)
      Dir.glob(pattern).sort.each do |file|
        push UIO.file(file)
      end.size
    end

    def inspect
      "#{self.class} (%d)" % size
    end

    def select(&block)
      self.class.new.concat super &block
    end

    def save
      sum { |i| i.save ? 1 : 0 }
    end

  end

end
