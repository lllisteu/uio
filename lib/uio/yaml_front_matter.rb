require 'yaml'

module UIO

  YAML_FRONT_MATTER_REGEX = /\A(?<yaml>---\n.*?)^(---\n?)/m
  YAML_PERMITTED_CLASSES  = [Time]

  class << self

    def split_yaml_front_matter(text)
      if match = text.force_encoding('UTF-8').match(YAML_FRONT_MATTER_REGEX)
        [
          match[:yaml],
          match.post_match
        ]
      end
    end

    def parse_yaml_front_matter(text)
      if parts = split_yaml_front_matter(text)
        [
          YAML.safe_load(parts[0], permitted_classes: YAML_PERMITTED_CLASSES) || {},
          parts[1]
        ]
      end
    end

    def dump_yaml_front_matter(array)
      ( array[0].any? ? array[0].to_yaml : "---\n" ) + "---\n" + array[1].to_s
    end

  end

end
