class SimpleLog
  class << self
    def info(msg)
      File.open("log/running.log", "a") do |f|
        f.puts msg
      end
    end
  end
end