module UIO
end

%w(

  version

  item

  collection

).each { |f| require "uio/#{f}" }

