require_relative "base"
require "open3"

module RunnerTool
  module Backends
    class Local < Base

      private

      def execute_cmd(cmd)
        Open3.popen3(cmd.cmd) do |stdin, stdout, stderr, wait_thr|
          { :stdout => stdout.read.chomp, :stderr => stderr.read.chomp,
            :exit_status => wait_thr.value.exitstatus }
        end
      end

    end
  end
end
