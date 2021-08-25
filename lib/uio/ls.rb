require 'uio'
require 'uio/search'

module UIO

  class Collection

    def ls(regex=nil)
      ( regex ? search(regex) : self ).each do |i|
        puts "%s %14.14s %.60s" % [
          ( i.content.empty? ? ' ' : 'c' ),
          i['uid'],
          i.title
        ]
      end
    end

  end

end