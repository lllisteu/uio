require 'uio/shared/log'

module UIO

  class << self
    include UIO::Shared::Log
  end

end

require 'uio/version'
require 'uio/item'
require 'uio/collection'
require 'uio/program'
