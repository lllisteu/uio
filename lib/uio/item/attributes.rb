require 'uio/content'

module UIO

  class Item

    def data
      reject { |k,v| k == 'content' }
    end

    def title
      self['title']
    end

    def title=(text)
      self['title'] = text.to_s
    end

    def content
      self['content']
    end

    def content=(text)
      self['content'] = UIO::Content.new text.to_s
    end

  end

end
