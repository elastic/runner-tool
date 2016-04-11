require "runner-tool/version"
require "runner-tool/dsl"
require "runner-tool/command"
require "runner-tool/runners"

include RunnerTool::DSL

module RunnerTool

  class Configuration
    attr_accessor :username, :password, :host, :port
    def initialize
      @username = "vagrant"
      @host     = "127.0.0.1"
      @password = "vagrant"
      @port     = 22
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

end
