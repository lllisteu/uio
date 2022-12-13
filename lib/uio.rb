module UIO
end

%w(

  version

  base

  collection

  ls edit

).each { |f| require "uio/#{f}" }

