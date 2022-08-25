module UIO
end

%w(

  version

  base

  collection

  ls edit choose

).each { |f| require "uio/#{f}" }

