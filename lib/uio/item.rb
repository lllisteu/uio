require 'uio/shared/log'

module UIO
  class Item < Hash

    include UIO::Shared::Log

    def inspect
      "#{self.class} (%s)" % (file || '-')
    end

  end
end

require 'uio/base'

%w(

  attributes

  file_attr

  yaml_front_matter

  blosxom

  io

).each { |f| require "uio/item/#{f}" }
