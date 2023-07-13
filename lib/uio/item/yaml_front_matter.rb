require 'yaml'

module UIO

  YAML_FRONT_MATTER_REGEX = /\A(?<yaml>---\n.*?)^(---\n?)/m

  def self.parse_yaml_front_matter(text)
    if match = text.match(YAML_FRONT_MATTER_REGEX)
      [
        YAML.safe_load(match[:yaml], permitted_classes: [Time] ) || {},
        match.post_match
      ]
    end
  end

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
