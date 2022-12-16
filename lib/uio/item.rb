module UIO
  class Item
  end
end

%w(

  base

  attributes

  file_attr

  yaml_front_matter

  blosxom

).each { |f| require "uio/item/#{f}" }
