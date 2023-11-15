module UIO

  BLOSXOM_META_REGEX = /^#\s*(?<key>[\S&&[^:]]+)\s*:\s*(?<value>.*)$/

  def self.parse_blosxom(text)
    lines = text.lines
    data = {}
    if lines.any? and ( lines.first !~ BLOSXOM_META_REGEX )
      data['title'] = lines.shift.chomp
    end
    while ( lines.any? ) do
      break if lines.first !~ BLOSXOM_META_REGEX
      data[$~[:key]] = $~[:value]
      lines.shift
    end
    [
      data,
      lines.any? ? lines.join : ''
    ]
  end

  class Item

    def load_blosxom(text)
      result = UIO.parse_blosxom(text)
      replace result[0]
      self.content = result[1]
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
