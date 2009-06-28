require File.expand_path(File.dirname(__FILE__) + '/monitor')

class DiskfullMonitor < Monitor

  def check
    raise "not config for diskfull monitor yet!" if @monitor_config.nil? or @monitor_config["disks"].nil? or @monitor_config["threshold"].nil?

    # load configs
    threshold = get_threshold
    disks_to_be_checked = @monitor_config["disks"]

    # get disk space info
    if RUBY_PLATFORM =~ /solaris/
      disks = `df -h|awk '{print $1}'`.split("\n")
      spaces = `df -h|awk '{print $5}'`.split("\n")
    else
      disks = `df -P|awk '{print $1}'`.split("\n")
      spaces = `df -P|awk '{print $5}'`.split("\n")
    end

    # generate report form from disk space info
    @report_title = "#{@server_name} - LOW disk space alarm!"
    disks.each_with_index do |disk, i|
      if disks_to_be_checked.include?(disk) and spaces[i].gsub('%','').to_i > threshold
        @report_body << "Disk:'#{disk}' used #{spaces[i]} space. <br>"
      end
    end

    @report_body << "<br>( the threshold is #{threshold}% for used space )" if @report_body.size > 0
  rescue Exception > e
    SimpleLog.info "!!!!!!!!!!!! #{e.to_s}"
  end
  
  protected
  
  def get_threshold
    offduty_time? ? @monitor_config["offduty_threshold"] : @monitor_config["threshold"]
  end
end