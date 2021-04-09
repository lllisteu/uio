require_relative 'lib/uio/version'

Gem::Specification.new do |s|

  s.name     = 'uio'
  s.summary  = 'UIO'
  s.version  = UIO::VERSION

  s.homepage = 'https://github.com/lllisteu/uio'
  s.authors  = [ 'lllist.eu' ]
  s.license  = 'MIT'

  all_files     = `git ls-files -z`.split("\x0")
  s.files       = all_files.grep(%r{^(bin|lib)/})
  s.executables = all_files.grep(%r{^bin/.+}) { |f| File.basename(f) }

  s.required_ruby_version = '>=2.2.0'

  s.metadata = {
    'homepage_uri'      => 'https://github.com/lllisteu/uio',
    'changelog_uri'     => 'https://github.com/lllisteu/uio/blob/master/History.md',
    'documentation_uri' => 'https://www.rubydoc.info/gems/uio',
  }

end
