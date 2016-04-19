require "spec_helper"
require "runner-tool/rspec"

RSpec.configure do |c|
  c.include InstallHelper
end

describe "Helpers" do

  before(:all) do
    download("logstash_2.3.1-1_all.deb")
  end

  it "is installed" do
    install("logstash_2.3.1-1_all.deb")
    expect("logstash").to be_installed
  end

  xit "is running" do
    start_service "logstash"
    expect("logstash").to be_running
    stop_service  "logstash"
  end
end
