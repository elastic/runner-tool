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
      end

      def upload!(cmd)
        puts "ssh.upload! #{cmd}"
      end

      def exec!(cmd)
        Command.new(host, cmd).tap do |cmd|
           status = execute_cmd(cmd)
           cmd.update_status(status)
        end
      end

      private

      def config
        RunnerTool.configuration
      end

    end
  end
end
