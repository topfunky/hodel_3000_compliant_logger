require 'logger'
require 'English'
require 'socket'

# A logger for use with pl_analyze and other tools that expect syslog-style log output.
class Hodel3000CompliantLogger < Logger

  ##
  # Note: If you are using FastCGI you may need to hard-code the hostname here instead of using Socket.gethostname

  def format_message(severity, timestamp, progname, msg)
    "#{timestamp.strftime("%b %d %H:%M:%S")} #{hostname} rails[#{process_id}]: #{msg2str(msg).gsub(/\n/, '').lstrip}\n"
  end

  private

  def hostname
    @parsed_hostname ||= Socket.gethostname.split('.').first
  end

  def process_id
    @process_id ||= "#{$PID}:#{Thread.current.object_id}"
  end

  def msg2str(msg)
    case msg
    when ::String
      msg
    when ::Exception
      "#{ msg.message } (#{ msg.class }): " <<
      (msg.backtrace || []).join(" | ")
    else
      msg.inspect
    end
  end

end
