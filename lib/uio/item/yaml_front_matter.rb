require 'yaml'

module UIO
  class Item

    YAML_FRONT_MATTER_REGEX = /\A(?<yaml>---\n.*?)^(---\n?)/m

    def load_yaml_front_matter(text)
      if match = text.match(YAML_FRONT_MATTER_REGEX)
        self.data    = YAML.safe_load(match[:yaml], permitted_classes: [Time] ) || {}
        self.content = match.post_match
        self
      else
        nil
      end
    end

    def to_yaml_front_matter
      ( data.any? ? data.to_yaml : "---\n" ) + "---\n" + content.to_s
    end

  end
end
