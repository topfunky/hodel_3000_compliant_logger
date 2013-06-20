$: << File.dirname(__FILE__) + "/../lib"

require 'rspec'
require 'hodel_3000_compliant_logger'
require 'stringio'

describe Hodel3000CompliantLogger do

  before :each do
    @out = StringIO.new
    @log = Hodel3000CompliantLogger.new(@out)
    Socket.stub(:gethostname).and_return('hostname.domain')
  end

  it "should log stuff in a syslog-like format so that Eric Hodel's Rails Analyzer Tools can parse it" do
    msg = "Yo ho hello there!"
    @log.info(msg)
    @out.string.should match(/^\w{3} \d{2} \d{2}:\d{2}:\d{2} hostname rails\[\d+|\d+\]: #{msg}\n$/)
  end

  it "should handle an Exception object used as an argument in Logger#error, rather than blow chunks" do
    @log.error(Exception.new)
    @out.string.should match(/Exception/)
  end

  it "should display a semi-readable stack trace (albiet on one line) when Logger#error(SomeException) was called" do
    @log.error(toss_runtime_error)
    @out.string.should match(/.*? \| .*? \| .*? \|/) # pipe separated stack frames
    @out.string.should match(/\n$/)
    @out.string.count("\n").should == 1
  end

  it "should replace newlines in message with an empty string" do
    msg = "Yo\nho\nhello\nthere!"
    @log.info(msg)
    @out.string.should match(/^\w{3} \d{2} \d{2}:\d{2}:\d{2} hostname rails\[\d+:\d+\]: Yohohellothere!\n$/)
  end

  def toss_runtime_error
    raise "Catastrophic Failure"
  rescue => e
    return e
  end
end

