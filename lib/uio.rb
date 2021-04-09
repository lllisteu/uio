module UIO
end

%w(

  version

).each { |f| require "uio/#{f}" }

