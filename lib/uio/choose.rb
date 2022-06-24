module UIO

  module U

    # From:
    # - https://gist.github.com/acook/4190379
    def self.read_char
      STDIN.echo = false
      STDIN.raw!

      input = STDIN.getc.chr
      if input == "\e" then
        input << STDIN.read_nonblock(3) rescue nil
        input << STDIN.read_nonblock(2) rescue nil
      end
    ensure
      STDIN.echo = true
      STDIN.cooked!

      return input
    end

  end

  class Collection

    def choose
      return nil unless self.any?
      cursor = 0
      while true
        i = self[cursor]
        # TODO: duplicates ls
        print "\r%s %14.14s %-60.60s" % [
          ( i.content.empty? ? ' ' : 'c' ),
          i['uid'],
          i.title
        ]

        c = UIO::U.read_char
        case c
          when "\e[A"
            cursor = cursor - 1
          when "\e[B"
            cursor = cursor + 1
          when "\e[H", "\e\e[A", 'a' # home, option-up, 'a'
            cursor = 0
          when "\e[F", "\e\e[B", 'z' # end, option-down, 'z'
            cursor = size - 1
          when "\r"
            print "\e[2K\r"
            break self[cursor]
          when "\e"
            print "\e[2K\r"
            break nil
        end
        cursor = [0, self.size - 1, cursor].sort[1]
      end
    end

  end

end
