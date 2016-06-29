require 'locomotivecms_solid'
require 'erpify/liquid/drops/base'
require 'erpify/liquid/drops/session'

%w{. tags drops}.each do |dir|
  Dir[File.join(File.dirname(__FILE__), 'liquid', dir, '*.rb')].each { |lib| require lib }
end
