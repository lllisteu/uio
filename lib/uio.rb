module UIO
end

%w(

  version

  base

  collection

  search ls edit choose

).each { |f| require "uio/#{f}" }

