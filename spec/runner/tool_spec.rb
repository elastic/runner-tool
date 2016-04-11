require 'spec_helper'

describe RunnerTool::Backends::Ssh do

  let(:options) { {in: :serial} }
  let(:host)    { "localhost" }

  let(:ssh_connection) do
    double("ssh_connection")
  end

  before(:each) do
    allow(ssh_connection).to receive(:exec!)
    allow(Net::SSH).to receive(:start).and_yield(ssh_connection)
  end

  it "should call the exec method witht he right parameters" do
    expect(subject).to receive(:exec!).with("foo")
    subject.exec(host) do |cmd|
      exec! "foo"
    end
  end

  it "should set the right hostname" do
    expect(RunnerTool::Command).to receive(:new).with(host, "bar").and_call_original
    subject.exec(host) do |cmd|
      exec! "bar"
    end
  end

end
