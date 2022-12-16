require 'uio/markdown'

module UIO

  class Item

    def data
      @data ||= {}
    end

    def data=(hash)
      @data = hash
    end

    def [](key)
      data[key]
    end

    def []=(key, value)
      data[key] = value
    end

    def title
      data['title'] || ''
    end

    def title=(text)
      data['title'] = text.to_s
    end

    def content
      @content ||= UIO::Markdown.new
    end

    def content=(text)
      content.replace text.to_s
    end

    def clear
      data.clear
      content.clear
    end

  end

end
