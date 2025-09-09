module UIO

  class << self

    def file(file)
      Item.new file: file
    end

  end


  class Item

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
