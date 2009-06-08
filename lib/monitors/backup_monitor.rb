class BackupMonitor < Monitor
  
  def check
    # check config
    return if @monitor_config.nil? or @monitor_config["dir"].nil? or @monitor_config["period"].nil?

    # check time
    return if Time.now.hour != @monitor_config["period"].to_i

    # load configs
    backup_dir = @monitor_config["dir"]

    # check database backup file
    timestamp = Time.now.strftime("%Y%m%d")
    files = `ls #{backup_dir}/*#{timestamp}*.tar.gz 2> /dev/null`.split("\n")

    # generate report
    if files.size == 0
      @report_title = "No database backup alarm"
      @report_body << "There is no database backup file found:'#{backup_dir}/*#{timestamp}*.tar.gz'"
    end

    report
  end

end
