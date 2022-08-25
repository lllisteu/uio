require 'uio'

module UIO

  class Base

    def ls
      puts _view_ls
    end

    private

    def _view_ls
      "%s%s%s %14.14s %-60.60s" % [
        ( ! content.empty?             ? 'c' : ' ' ),
        ( data['link']                 ? 'l' : ' ' ),
        ( (data['lat'] or data['lon']) ? 'g' : ' ' ),
        data['uid'],
        title
      ]
    end

  end

  class Collection

    def ls
      each &:ls
    end

  end

end
