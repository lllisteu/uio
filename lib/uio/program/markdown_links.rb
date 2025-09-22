# title       : Markdown links
# dt-created  : 2023-11-19 14:39:07 GMT
# description : Extract Markdown links from content

module UIO
  class Content

    # Returns Markdown inline links found in the text.
    #
    # Markdown example (title is optional):
    # [example link](http://example.com/ "With a Title")
    #
    # For each link returns:
    # - text
    # - URL
    # - title, if there is one
    #
    # Specified by:
    # - https://daringfireball.net/projects/markdown/basics
    def markdown_links
      scan(%r{(?:^|[^\!])\[([^\]]+)\]\(([^"\)]+)(?:\ \"([^\"]*)\")?\)})
    end

  end
end
