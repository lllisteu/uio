module UIO

  class << self

    def get(file)
      Base.get file
    end

  end


  class Base

    # Regular expression used for parsing key-value pairs
    IO_BLOSXOM_REGEX = /^#\s*(?<key>[\S&&[^:]]+)\s*:\s*(?<value>.*)$/

    class << self

      def get(file)
        new file: file
      end

    end

    attr_reader :file

    attr_reader :content

    def initialize(file: nil)
      if file
        @file = file
        load_blosxom read
      end
    end

    def inspect
      "#{self.class} (%s)" % (file || '-')
    end

    def read
      file ? IO.read(file) : nil
    end

    def data
      @data ||= {}
    end

    def [](key)
      data[key]
    end

    def content=(text)
      @content = text.to_s
    end

    def load_blosxom(text)
      lines = text.lines
      lines.any? and ( lines.first !~ IO_BLOSXOM_REGEX ) and ( self.data['title'] = lines.shift.chomp )
      while ( lines.any? ) do
        break if lines.first !~ IO_BLOSXOM_REGEX
        self.data[ $~[:key] ] = $~[:value]
        lines.shift
      end
      self.content = lines.join if lines.any?
      self
    end

    def to_blosxom(title_in_data=false, prefix: '# ')
      data_keys   = data.keys - ( title_in_data ? [] : ['title'] )
      data_format = "#{prefix}%-#{data_keys.map(&:length).max}s : %s"
      [
        ( title_in_data ? nil : data['title'] ),
        data_keys.map { |k| data_format % [ k, data[k] ] },
        content
      ].flatten.compact.join("\n")
    end

  end

end
