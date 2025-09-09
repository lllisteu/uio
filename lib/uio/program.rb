module UIO

  class << self

    def program(*names)
      if names.any?
        names.map do |name|
          if file = program_resolve(name)
            require(file) ? file : false
          else
            nil
          end
        end
      else
        program 'default'
      end
    end

    alias prg program

    def program_path
      @@program_path ||= [
        ENV['UIO_PROGRAM_DIRECTORY'],
        File.join(File.dirname(__FILE__), 'program'),
      ].compact
    end

    def program_resolve(name)
      program_path.each do |path|
        file = File.join(path, name) + '.rb'
        if File.exist? file
          return file
        end
      end
      nil
    end

  end

end
