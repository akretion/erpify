require 'rspec'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'erpify'))

RSpec.configure do |c|
  c.mock_with :rspec
end

