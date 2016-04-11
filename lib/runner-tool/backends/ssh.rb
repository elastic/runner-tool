require_relative "base"
require "net/ssh"

module RunnerTool
  module Backends
    class Ssh < Base

      def sudo_exec!(cmd)
        Command.new(host, cmd).tap do |_cmd|
          status = execute_cmd(_cmd, :sudo => true)
          _cmd.update_status(status)
        end
      end

      private

      def execute_cmd(cmd, options={})
        stdout, stderr, exit_status = "", "", -1
        host, port = cmd.host.split(":")
        Net::SSH.start(host, config.username, {:password => config.password, :port => port}) do |ssh|
          command_string = command(cmd, options)
          ssh.exec!(command_string) do |channel, stream, data|
            stdout << data if stream == :stdout
            stderr << data if stream == :stderr
            channel.on_request("exit-status") do |ch, _data|
              exit_status = _data.read_long
            end
          end
        end
        { :stdout => stdout, :stderr => stderr, :exit_status => exit_status }
      end

      def command(cmd, options={})
        run_sudo = options.fetch(:sudo, false)
        if run_sudo
          "#{sudo} -p '#{prompt}' #{cmd.cmd}"
        else
          cmd.cmd
        end
      end

      def prompt
       "Password: "
      end

      def sudo
        "sudo"
      end

    end
  end
end
