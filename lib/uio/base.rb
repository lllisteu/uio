module UIO

  class << self

    def get(file)
      unless defined? @@warned_uio_get_deprecation
        warn "Warning: 'UIO.get' has been deprecated and will soon be removed."
        @@warned_uio_get_deprecation = true
      end
      Item.get file
    end

    def file(file)
      Item.new file: file
    end

  end


  class Item

    class << self

      def get(file)
        new file: file
      end

    end

    def initialize(file: nil)
      if file
        @file = file
        load if File.exist?(file)
      end
    end

    def load
      begin
        text = read_file
        load_yaml_front_matter(text) || load_blosxom(text)
      rescue
        error "#{$!} (#{file})"
      end
    end

    def reload
      clear
      load
    end

    def save
      if file
        File.write file, to_yaml_front_matter
      end
    end

  end

end
