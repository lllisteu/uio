module UIO

  class << self

    def parse(text)
      parse_yaml_front_matter(text) || parse_blosxom(text)
    end

    def stdin
      result = parse(STDIN.read)

      item = Item.new
      item.replace result[0]
      item.content = result[1]
      item
    end

  end

end
