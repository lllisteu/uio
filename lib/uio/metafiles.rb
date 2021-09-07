require 'pathname'

module UIO

  class << self

    def meta_filenames(path, filename)
      Pathname.new(File.expand_path path).ascend.to_a.push(defaults_dir).map do |dir|
        File.join(dir, filename)
      end
    end

    private

    def defaults_dir
      @defaults_dir ||= File.join File.dirname(__FILE__), 'defaults'
    end

  end

end
