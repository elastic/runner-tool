require_relative "base"
require "runner-tool/backends/ssh"

module RunnerTool
  module Runners
    class Serial < Base

      attr_reader :runner

      def initialize(options={})
        @runner = RunnerTool::Backends::Ssh.new(options)
      end

      def exec_on(hosts, &block)
        hosts.each do |host|
          runner.exec(host, &block)
        end
        runner.close_connections
      end
    end
  end
end
