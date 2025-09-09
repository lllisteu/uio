require 'uio/shared/log'
require 'uio/content'
require 'uio/yaml_front_matter'

module UIO
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

  file_attr

  blosxom

  io

).each { |f| require "uio/item/#{f}" }
