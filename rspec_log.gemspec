$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')

Gem::Specification.new do |s|
  s.name        = 'rspec_log'
  s.version     = `git describe --tags`.freeze if (/fatal/ =~ `git describe --tags`).nil?
  s.date        = Date.today

  s.summary     = 'An RSpec Logger that is persistent throughout multiple rspec files'
  s.description = %(
    Provides a Logging system separate to RSpec that can be persistent throughout
    multiple runs of RSpec i.e. multiple files.
  )

  s.licenses    = ['MIT']
  s.authors     = ['Andrea Capri']
  s.email       = ['andrea.a.capri@gmail.com']

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 3.0'

  s.add_runtime_dependency 'colorize'

  s.require_path  = 'lib'
  s.files         = %w(LICENSE README.md) + Dir.glob('{lib}/**/*')
end
