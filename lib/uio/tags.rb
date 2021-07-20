module UIO


  class Base

    def tags
      data['tags'] || []
    end

    def tagged?(text)
      tags.map(&:downcase).include? text.downcase
    end

  end


  class Collection

    def tagged(text)
      select { |i| i.tagged? text }
    end

    def tags
      map(&:tags).flatten.uniq(&:downcase)
    end

  end


end
