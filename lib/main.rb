#!/usr/bin/env ruby
['simplemail/simplemail', 'monitors/monitor', 'monitors/diskfull_monitor', 'monitors/backup_monitor'].each do |file|
  require File.expand_path(File.dirname(__FILE__) + '/' + file)
end

monitors = [DiskfullMonitor, BackupMonitor]
monitors.each do |monitor|
  monitor.new.check
end
