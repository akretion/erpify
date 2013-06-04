require 'locomotive_liquid'
require 'erpify/liquid/drops/base'

%w{. tags drops}.each do |dir|
  Dir[File.join(File.dirname(__FILE__), 'liquid', dir, '*.rb')].each { |lib| require lib }
end
