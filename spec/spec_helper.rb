$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'runner-tool'

RSpec.configure do |config|
  config.before(:all) do
    RunnerTool.configure
  end
end
