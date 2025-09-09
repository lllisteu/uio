require 'uio/shared/log'
require 'uio/content'
require 'uio/yaml_front_matter'

module UIO

  class << self

    def parse(text)
      parse_yaml_front_matter(text) || parse_blosxom(text)
    end

    def stdin
      result = parse(STDIN.read)

      item = Item.new
      item.replace result[0]
      item.content = result[1]
      item
    end

  end

  class Item < Hash

    include UIO::Shared::Log

    def inspect
      "#{self.class} (%s)" % (file || '-')
    end

    def data
      reject { |k,v| k == 'content' }
    end

    def content
      self['content']
    end

    def content=(text)
      self['content'] = UIO::Content.new text.to_s
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

    def load_yaml_front_matter(text)
      if result = UIO.parse_yaml_front_matter(text)
        replace result[0]
        self.content = result[1]
      end
    end

    def to_yaml_front_matter
      UIO.dump_yaml_front_matter [data, content]
    end

  end
end

require 'uio/base'

%w(

  blosxom

).each { |f| require "uio/item/#{f}" }
