class Time
  class << self
    alias :local_now :now
    def now
      Time.local_now.gmtime + 60*60*8
    end
  end
end