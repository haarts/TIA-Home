require 'serialport'

def getUSBPort
  hit = Dir.entries("/dev/").find{|e| e =~ /USB/}
  File.join('/','dev',hit)
end

p = SerialPort.new(getUSBPort)
logfile = "../log/data.log"
if not File.exists?(File.join(logfile.split("/")[0..-2]))
  Dir.mkdir(File.join(logfile.split("/")[0..-2]))
end

file = File.open(logfile, "a")
file.sync = true

fork do
  Signal.trap("TERM") do
    file.close
    Kernel.exit!
  end
  while true do
    begin
      file.write(Time.now.to_s + "," + p.readline)
    rescue IOError
    end
  end
end

