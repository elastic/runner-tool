require "runner-tool/command"

module RunnerTool
  module Backends
    class Base

      attr_reader :host, :options

      def initialize(options={})
        @options = options
      end

      def exec(host, &block)
        @host = host
        instance_exec(host, &block)
        @host = nil
      end

      def upload!(cmd)
        puts "ssh.upload! #{cmd}"
      end

      private
      def exec!(cmd)
        Command.new(host, cmd).tap do |_cmd|
           status = execute_cmd(_cmd)
           _cmd.update_status(status)
        end
      end

      def config
        RunnerTool.configuration
      end

    end
  end
end
