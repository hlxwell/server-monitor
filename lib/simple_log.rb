class SimpleLog
  class << self
    def info(msg)
      File.open(File.expand_path(File.dirname(__FILE__) + "/../log/running.log"), "a") do |f|
        f.puts msg
      end
    end
  end
end