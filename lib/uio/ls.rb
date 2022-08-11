require 'uio'
require 'uio/search'

module UIO

  class Base

    def ls
      puts "%s%s%s %14.14s %.60s" % [
        ( ! content.empty?             ? 'c' : ' ' ),
        ( data['link']                 ? 'l' : ' ' ),
        ( (data['lat'] or data['lon']) ? 'g' : ' ' ),
        data['uid'],
        title
      ]
    end

  end

  class Collection

    def ls(regex=nil)
      ( regex ? search(regex) : self ).each &:ls
    end

  end

end
