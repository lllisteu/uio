module UIO
  class Item

    BLOSXOM_META_REGEX = /^#\s*(?<key>[\S&&[^:]]+)\s*:\s*(?<value>.*)$/

    def load_blosxom(text)
      lines = text.lines
      lines.any? and ( lines.first !~ BLOSXOM_META_REGEX ) and ( self.title = lines.shift.chomp )
      while ( lines.any? ) do
        break if lines.first !~ BLOSXOM_META_REGEX
        self[$~[:key]] = $~[:value]
        lines.shift
      end
      self.content = lines.join if lines.any?
      self
    end

    def to_blosxom(title_in_data=false, prefix: '# ')
      data_keys   = data.keys - ( title_in_data ? [] : ['title'] )
      data_format = "#{prefix}%-#{data_keys.map(&:length).max}s : %s"
      [
        ( title_in_data ? nil : data['title'] ),
        data_keys.map { |k| data_format % [ k, data[k] ] },
        content
      ].flatten.compact.join("\n")
    end

  end
end
