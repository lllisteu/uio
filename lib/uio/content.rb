module UIO

  class Content < String

    def links
      scan(/\[(.*)\]\((.*)\)/)
    end

  end

end
