require 'uio/yaml_front_matter'

module UIO

  class Item

    def load_yaml_front_matter(text)
      if result = UIO.parse_yaml_front_matter(text)
        replace result[0]
        self.content = result[1]
      end
    end

    def to_yaml_front_matter
      ( data.any? ? data.to_yaml : "---\n" ) + "---\n" + content.to_s
    end

  end
end
