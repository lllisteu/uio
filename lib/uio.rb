module UIO
end

%w(

  version

  base

  collection

).each { |f| require "uio/#{f}" }

