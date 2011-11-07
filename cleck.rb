require 'serialport'

p = SerialPort.new("/dev/ttyUSB0")
file = File.open("log/data.log", "a")
file.sync = true
@stop = false
pid = fork do
  Signal.trap("TERM") do
    @stop = true
    file.close
  end
  while not @stop do
     file.write(p.readline)
  end
end
