require "runner-tool/runners/serial"

module RunnerTool
  class Controller

    attr_reader :hosts

    def initialize(hosts)
      @hosts = hosts
    end

    def run(options, &block)
      Runners::Serial.new(options).exec_on(hosts, &block)
    end

  end
end
