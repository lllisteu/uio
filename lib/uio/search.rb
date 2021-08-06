module UIO

  class Base

    def search(regex)
      ( (title || '').match regex ) or ( (content || '').match regex )
    end

  end

  class Collection

    def search(regex)
      select { |i| i.search regex }
    end

  end

end
