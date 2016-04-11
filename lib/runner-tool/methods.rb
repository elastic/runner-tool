require "runner-tool/controller"
require "runner-tool/backends/local"

module RunnerTool

  class AtRemote
    def self.run(servers, options, &block)
      Controller.new(servers).run(options, &block)
    end
  end

  class AtLocally
    def self.run(&block)
      Backends::Local.new.exec("localhost", &block)
    end
  end

end
