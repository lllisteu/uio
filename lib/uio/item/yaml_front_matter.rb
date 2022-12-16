require 'yaml'

module UIO
  class Item

    YAML_FRONT_MATTER_REGEX = /\A(---\n.*?)^(---\n?)/m

    def load_yaml_front_matter(text)
      if text =~ YAML_FRONT_MATTER_REGEX
        data.merge!( YAML.safe_load($1, permitted_classes: [Time] ) || {} )
        self.content = $'
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
