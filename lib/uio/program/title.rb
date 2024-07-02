# title       : Title
# dt-created  : 2024-06-26 06:51:29 GMT
# description : Get and set item title

class UIO::Item

  # Gets the title
  def title
    self['title']
  end

  # Sets the title
  def title=(text)
    self['title'] = text.to_s
  end

end
