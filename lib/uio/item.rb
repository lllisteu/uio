require 'uio/shared/log'

module UIO
  class Item < Hash

    include UIO::Shared::Log

  end
end

require 'uio/base'

%w(

  base

  attributes

  file_attr

  yaml_front_matter

  blosxom

  io

).each { |f| require "uio/item/#{f}" }
