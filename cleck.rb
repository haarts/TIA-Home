require 'serialport'

p = SerialPort.new("/dev/ttyUSB0")
file = File.open("log/data.log", "a")
pid = fork do
  Signal.trap("TERM") do
    file.close
  end
  while true do
     file.write(p.readline)
  end
end
