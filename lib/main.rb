#!/usr/bin/env ruby
require 'monitors/monitor'
require 'monitors/diskfull_monitor'
require 'monitors/backup_monitor'

monitors = [DiskfullMonitor, BackupMonitor]


monitors.each do |monitor|
  monitor.new.check
end
