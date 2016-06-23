require_relative "base"
require "net/ssh"
require "net/scp"
require "runner-tool/connection_pool"

module RunnerTool
  module Backends
    class Ssh < Base

      attr_reader :pool

      def initialize(options={})
        super(options)
        @pool = ConnectionPool.instance
      end

      def sudo_exec!(cmd)
        Command.new(host, cmd).tap do |_cmd|
          status = execute_cmd(_cmd, :sudo => true)
          _cmd.update_status(status)
        end
      end

      def upload!(file)
        Command.new(host, file).tap do |_cmd|
         status = upload_file(_cmd)
         _cmd.update_status(status)
        end
      end

      private

      def upload_file(cmd)
        host, port = cmd.host.split(":")
        Net::SCP.upload!(host, config.username,
                         cmd.cmd, cmd.cmd,
                         :ssh => { :password => config.password, :port => port })
        { :stdout => "Uploaded #{cmd.cmd} to #{host}", :stderr => "", :exit_status => 0 }
      end


      def execute_cmd(cmd, options={})
        stdout, stderr, exit_status = "", "", -1

        ssh_config = build_config_with(cmd)
        connection = pool.start(ssh_config)
        connection.exec!(command(cmd, options)) do |channel, stream, data|
          stdout << data if stream == :stdout
          stderr << data if stream == :stderr
          channel.on_request("exit-status") do |ch, _data|
            exit_status = _data.read_long
          end
        end
        { :stdout => stdout, :stderr => stderr, :exit_status => exit_status }
      end

      def build_config_with(cmd)
        host, port = cmd.host.split(":")
        { :host => host, :user => config.username,
          :options => {:password => config.password, :port => port }}
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
