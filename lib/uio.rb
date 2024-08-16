require 'uio/shared/log'

module UIO

  class << self
    include UIO::Shared::Log
  end

end

%w(

  version

  item

  collection

  program

).each { |f| require "uio/#{f}" }

