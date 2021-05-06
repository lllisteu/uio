module UIO
end

%w(

  version

  base

).each { |f| require "uio/#{f}" }

