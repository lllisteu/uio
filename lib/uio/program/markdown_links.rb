# title       : md links
# uid         : 20231119143907
# dt-created  : 2023-11-19 14:39:07 GMT
# description : Get Markdown links from content

class UIO::Content

    # Returns inline links defined in Markdown syntax.
    #
    # Specified by:
    # - https://daringfireball.net/projects/markdown/basics
    def md_links
      scan(%r{(?:^|[^\!])\[([^\]]+)\]\(([^"\)]+)(?:\ \"([^\"]*)\")?\)}).map &:compact
    end

end
