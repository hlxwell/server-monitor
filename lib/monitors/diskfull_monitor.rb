require File.expand_path(File.dirname(__FILE__) + '/monitor')

class DiskfullMonitor < Monitor

  def check
    return if @monitor_config.nil? or @monitor_config["disks"].nil? or @monitor_config["threshold"].nil?

    # load configs
    threshold = @monitor_config["threshold"]
    disks_to_be_checked = @monitor_config["disks"]

    # get disk space info
    disks = `df -P|awk '{print $1}'`.split("\n")
    spaces = `df -P|awk '{print $5}'`.split("\n")

    # generate report form from disk space info
    @report_title = "LOW disk space alarm ( the threshold is #{threshold}% for used space )"
    disks.each_with_index do |disk, i|
      if disks_to_be_checked.include?(disk) and spaces[i].gsub('%','').to_i > threshold
        @report_body << "Disk:'#{disk}' used #{spaces[i]} space. <br>"
      end
    end
  end
  
end