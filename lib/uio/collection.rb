require 'uio/shared/log'

module UIO

  class << self

    def collection
      Collection.new
    end

  end


  class Collection < Array

    include UIO::Shared::Log

    def inspect
      "#{self.class} (%d)" % size
    end

    def select
      self.class.new.concat super
    end

  end

end
