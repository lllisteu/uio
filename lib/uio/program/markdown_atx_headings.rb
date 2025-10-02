# title       : Markdown atx headings
# dt-created  : 2024-08-06 08:03:29 GMT
# description : Extract Markdown atx-style headings ('headers') from text

module UIO
  class Text

    # Returns Markdown atx-style headings found in the text.
    #
    # Markdown example:
    # ### Level 3 Heading
    #
    # For each heading returns:
    # - text
    # - heading level (1..6)
    # - the number of the line where the heading was found
    #
    # Specified by:
    # - https://daringfireball.net/projects/markdown/basics
    def markdown_atx_headings
      pointer = -1
      lines.map do |line|
        pointer += 1
        # Regular expression from markdown.pl lines 744-754
        # https://daringfireball.net/projects/downloads/Markdown_1.0.1.zip
        if line.match /^(\#{1,6})[ \t]*(.+?)[ \t]*\#*\n/
          [$2, $1.length, pointer]
        end
      end.compact
    end

  end
end
