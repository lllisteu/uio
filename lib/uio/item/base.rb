module UIO
  class Item

    def inspect
      "#{self.class} (%s)" % (file || '-')
    end

  end
end
