require 'spec_helper'

describe RunnerTool::Backends::Ssh do

  let(:options) { {in: :serial} }
  let(:host)    { "localhost" }

  let(:ssh_connection) do
    double("ssh_connection")
  end

  let(:block) do
    Proc.new do |cmd|
      exec! "foobar"
    end
  end

  before(:each) do
    allow(ssh_connection).to receive(:exec!)
    allow_any_instance_of(RunnerTool::ConnectionPool).to receive(:start).and_return(ssh_connection)
  end

  it "should call the exec method witht he right parameters" do
    expect(subject).to receive(:exec!).with("foobar")
    subject.exec(host,  &block)
  end

  it "should set the right hostname" do
    expect(RunnerTool::Command).to receive(:new).with(host, "foobar").and_call_original
    subject.exec(host,  &block)
  end

end
