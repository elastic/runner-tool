require "runner-tool/methods"

module RunnerTool
  module DSL
    def at(servers, options={}, &block)
      if (servers.is_a?(Symbol) && servers == :local)
        at_locally(&block)
      else
        AtRemote.run(servers, options, &block)
      end
    end

    def at_locally(&block)
      AtLocally.run(&block)
    end

  end
end
