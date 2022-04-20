module UIO

  class Content < String

    # Returns inline links defined in Markdown syntax.
    #
    # Specified by:
    # - https://daringfireball.net/projects/markdown/basics
    def links
      scan(%r{(?:^|[^\!])\[([^\]]+)\]\(([^"\)]+)(?:\ \"([^\"]*)\")?\)}).map &:compact
    end

  end

end
