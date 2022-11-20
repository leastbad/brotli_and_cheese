Gem::Specification.new do |s|
  s.name     = 'brotli_and_cheese'
  s.version  = '0.1.0'
  s.summary  = 'Per-message DEFLATE brotli compression extension for WebSocket connections'
  s.author   = 'leastbad'
  s.email    = 'hello@leastbad.com'
  s.homepage = 'https://github.com/leastbad/brotli_and_cheese'
  s.license  = 'Apache-2.0'

  s.extra_rdoc_files = %w[README.md]
  s.rdoc_options     = %w[--main README.md --markup markdown]
  s.require_paths    = %w[lib]

  s.files = %w[CHANGELOG.md LICENSE.md README.md] + Dir.glob('lib/**/*.rb')

  s.add_dependency 'brotli', '~> 0.1'

  s.add_development_dependency 'rspec'
end
