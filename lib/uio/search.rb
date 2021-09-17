module UIO

  class Base

    def match?(matchex)
      regex = (matchex.class == Regexp) ? matchex : Regexp.new(matchex.to_s, true)
      ( title.match? regex ) or ( content.match? regex )
    end

  end

  class Collection

    def search(regex)
      select { |i| i.match? regex }
    end

    alias s search

  end

end
