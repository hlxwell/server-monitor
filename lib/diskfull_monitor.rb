#!/usr/bin/env ruby

require 'simplemail'

# config zone
DISKS_TO_BE_MONITED = ['/dev/disk0s2', '/dev/disk0s3']
THRESHOLD = 50

# get disk space info
disks_report = `df -k|awk '{print $1}'`
spaces_report = `df -k|awk '{print $5}'`
disks = disks_report.split("\n")
spaces = spaces_report.split("\n")

# generate report from from disk space info
reports = ["LOW disk space alarm ( the threshold is #{THRESHOLD}% for used space ) <br>"]
disks.each_with_index do |disk, i|
  if DISKS_TO_BE_MONITED.include?(disk) and spaces[i].gsub('%','').to_i > THRESHOLD
    reports << "Disk:'#{disk}' used #{spaces[i]} space. <br>"
  end
end

# sendmail if disk space is bigger than threshold
if reports.size > 1
  mail = SimpleMail.new
  mail.to = "theplant development team <michael@theplant.jp>"
  mail.from = "dev2@theplant.jp"
  mail.sender = "the plant monitor center"
  mail.subject = reports[0]
  mail.text = reports.to_s
  mail.html = reports.to_s
  mail.send
  
  puts reports
else
  puts 'everything is ok!'
end