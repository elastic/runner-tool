require "net/ssh"
require "singleton"

module RunnerTool

  class Connection

    attr_reader :conn, :config

    def initialize(config)
      @config = config
    end

    def build
      @conn ||= connect
      self
    end

    def exec!(cmd, &block)
      retries = 0
      begin
        @conn.exec!(cmd, &block)
      rescue Net::SSH::Disconnect => e
        if retries < 5
          retries = retries + 1
          @conn = connect
          retry
        else
          raise e
        end
      end
    end

    def close
      @conn.close
    end

    def uid
      config.hash
    end

    private

    def connect
      Net::SSH.start(config[:host], config[:user], config[:options])
    end
  end

  class ConnectionPool

    include Singleton

    def initialize
      @connections = {}
    end

    def start(config)
      connection = Connection.new(config)
      return @connections[connection.uid] if @connections.include?(connection.uid)
      @connections[connection.uid] = connection.build
    end

    def close_all
      @connections.each_pair do |id, _|
        close(id)
      end
    end

    def close(id)
      @connections[id].close
    end

  end
end
