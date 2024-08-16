require 'uio/shared/log'

module UIO

  class << self

    def collection
      Collection.new
    end

    def glob(pattern)
      Collection.glob pattern
    end

    def dir(directory=Dir.pwd)
      glob "#{directory}/**/*.{txt,md,markdown}"
    end

  end


  class Collection < Array

    include UIO::Shared::Log

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

    def select
      self.class.new.concat super
    end

  end

end
