class DiskfullMonitor < Monitor

  def check
    return if @monitor_config["diskfull"].nil? or @monitor_config["diskfull"]["disks"].nil? or @monitor_config["diskfull"]["threshold"].nil?

    # load configs
    threshold = @monitor_config["diskfull"]["threshold"]
    disks_to_be_checked = @monitor_config["diskfull"]["disks"]

    # get disk space info
    disks = `df -k|awk '{print $1}'`.split("\n")
    spaces = `df -k|awk '{print $5}'`.split("\n")

    # generate report form from disk space info
    @report_title = "LOW disk space alarm ( the threshold is #{threshold}% for used space )"
    disks.each_with_index do |disk, i|
      if disks_to_be_checked.include?(disk) and spaces[i].gsub('%','').to_i > threshold
        @report_body << "Disk:'#{disk}' used #{spaces[i]} space. <br>"
      end
    end

    report
  end
  
end