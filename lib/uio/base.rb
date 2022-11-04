require 'uio/content'
require 'yaml'

module UIO

  class << self

    def get(file)
      Base.get file
    end

  end


  class Base

    # Regular expressions for parsing data
    BLOSXOM_META_REGEX      = /^#\s*(?<key>[\S&&[^:]]+)\s*:\s*(?<value>.*)$/
    YAML_FRONT_MATTER_REGEX = /\A(---\n.*?)^(---\n?)/m

    class << self

      def get(file)
        new file: file
      end

    end

    attr_reader :file

    def initialize(file: nil)
      if file
        @file = file
        load
      end
    end

    def inspect
      "#{self.class} (%s)" % (file || '-')
    end

    def clear
      data.clear
      content.clear
    end

    def read
      file ? IO.read(file, encoding: 'utf-8') : nil
    end

    def load
      text = read
      load_yaml_front_matter(text) || load_blosxom(text)
    end

    def reload
      clear
      load
    end

    def save
      if file
        File.write file, to_yaml_front_matter
      end
    end

    def data
      @data ||= {}
    end

    def title
      data['title'] || ''
    end

    def title=(text)
      data['title'] = text.to_s
    end

    def [](key)
      data[key]
    end

    def []=(key, value)
      data[key] = value
    end

    def content
      @content ||= UIO::Content.new
    end

    def content=(text)
      content.replace text.to_s
    end

    def load_blosxom(text)
      lines = text.lines
      lines.any? and ( lines.first !~ BLOSXOM_META_REGEX ) and ( self.data['title'] = lines.shift.chomp )
      while ( lines.any? ) do
        break if lines.first !~ BLOSXOM_META_REGEX
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

    def load_yaml_front_matter(text)
      if text =~ YAML_FRONT_MATTER_REGEX
        data.merge!( YAML.safe_load($1, permitted_classes: [Time] ) || {} )
        self.content = $'
        self
      else
        nil
      end
    end

    def to_yaml_front_matter
      ( data.any? ? data.to_yaml : "---\n" ) + "---\n" + content.to_s
    end

    def basename
      file ? File.basename(file, extname) : nil
    end

    def extname
      file ? File.extname(file) : nil
    end

    def expand_path
      file ? File.expand_path(file) : nil
    end

    def markup
      self['markup'] || ( ['.md', '.markdown'].include?(extname.downcase) ? 'markdown' : nil )
    end

  end

end
