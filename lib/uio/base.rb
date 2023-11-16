module UIO

  class << self

    def get(file)
      Item.get file
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

    def read
      file ? IO.read(file, encoding: 'utf-8') : nil
    end

    def load
      text = read
      load_yaml_front_matter(text) || load_blosxom(text)
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
