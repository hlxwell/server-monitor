require File.expand_path(File.dirname(__FILE__) + '/monitor')

class BackupMonitor < Monitor

  def check
    # check config
    return if @monitor_config.nil? or @monitor_config["dir"].nil?

    # load configs
    backup_dir = @monitor_config["dir"]

    # check database backup file
    timestamp = Time.now.strftime("%Y%m%d")
    files = `ls #{backup_dir}/*#{timestamp}*.tar.gz 2> /dev/null`.split("\n")

    # generate report
    if files.size == 0
      @report_title = "#{@server_name} - No database backup alarm!"
      @report_body << "There is no database backup file found at:'#{backup_dir}/*#{timestamp}*.tar.gz'"
    end
  end

end
