require 'coveralls'

Coveralls.wear!

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

require 'rspec'
require 'auto-deploy-test'

SimpleCov.start do
  add_filter 'spec'
end
