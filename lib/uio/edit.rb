module UIO

  class Base

    def edit
      raise "No ENV['EDITOR']" unless ENV['EDITOR']
      raise 'No file'          unless file

      system "#{ENV['EDITOR']} #{expand_path}"
    end

  end

end
