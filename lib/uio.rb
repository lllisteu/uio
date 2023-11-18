module UIO
end

%w(

  version

  item

  collection

  program

).each { |f| require "uio/#{f}" }

