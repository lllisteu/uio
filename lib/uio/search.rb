module UIO

  class Base

    def match?(regex)
      ( title.match? regex ) or ( content.match? regex )
    end

  end

  class Collection

    def search(regex)
      select { |i| i.match? regex }
    end

  end

end
