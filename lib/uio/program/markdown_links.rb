# title       : Markdown links
# dt-created  : 2023-11-19 14:39:07 GMT
# description : Get Markdown links from content

class UIO::Content

    # Returns inline links defined in Markdown syntax.
    #
    # Example (title is optional):
    # [example link](http://example.com/ "With a Title")
    #
    # Specified by:
    # - https://daringfireball.net/projects/markdown/basics
    def markdown_links
      scan(%r{(?:^|[^\!])\[([^\]]+)\]\(([^"\)]+)(?:\ \"([^\"]*)\")?\)}).map &:compact
    end

end
