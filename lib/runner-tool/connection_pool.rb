require "net/ssh"

module RunnerTool

  class Connection

    attr_reader :conn, :config

    def initialize(config)
      @config = config
    end

    def build
      @conn ||= Net::SSH.start(config[:host],
                               config[:user],
                               config[:options])
    end

    def close
      @conn.close
    end

    def uid
      config.hash
    end
  end

  class ConnectionPool

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
