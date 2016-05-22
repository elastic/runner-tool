module RunnerTool
  class Command

    attr_reader :host, :cmd, :stdout, :stderr, :exit_status

    def initialize(host, cmd)
      @host = host
      @cmd  = cmd
    end

    def update_status(status={})
      @stdout    = status[:stdout]
      @stderr    = status[:stderr]
      @exit_status = status[:exit_status]
      self
    end

  end
end
