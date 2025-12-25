require 'uio/shared/log'
require 'uio/text'
require 'uio/yaml_front_matter'

module UIO

  class << self

    def file(file)
      Item.new file: file
    end

    def stdin
      Item.new.load_string STDIN.read
    end

  end

  class Item < Hash

    include UIO::Shared::Log

    def initialize(file: nil)
      if file
        @file = file
        load if File.exist?(file)
      end
    end

    def load
      begin
        load_string read_file
      rescue
        error "#{$!} (#{file})"
      end
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

    def inspect
      "#{self.class} (%s)" % (file || '-')
    end

    def data
      reject { |k,v| k == 'text' }
    end

    def text
      self['text']
    end

    def text=(txt)
      self['text'] = UIO::Text.new txt.to_s
    end

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

    def read_file
      if file
        IO.read(file, encoding: 'utf-8')
      end
    end

    def load_string(txt)
      clear
      self.text = txt
      if result = UIO.parse_yaml_front_matter(txt)
        replace result[0]
        self.text = result[1]
      end
      self
    end

    def to_yaml_front_matter
      UIO.dump_yaml_front_matter [data, text]
    end

  end
end
