require File.expand_path(File.dirname(__FILE__) + '/../simplemail/simplemail')
require 'yaml'

class Monitor

  def initialize(server_name)
    # find file at config dir, if can't find it, use the "monitor_config_test.yml"
    begin
      raise if server_name.nil?    # not specify any server name
      config_file = "monitor_config_#{server_name}.yml"
      raise unless FileTest.exist?(File.expand_path(File.dirname(__FILE__) + '../../../config/' + config_file))  # file not exit
    rescue
      puts '### use test.yml as default ###'
      config_file = "monitor_config_test.yml"
    end

    @server_name = server_name ||= "test"
    @report_title = ""
    @report_body = []
    @config = YAML.load_file(File.expand_path(File.dirname(__FILE__) + "../../../config/#{config_file}"))
    @monitor_config = @config["monitors"][self.class.name]
  end

  def start
    check
    report
  end

protected
  def check
    raise "not implement yet!"
  end

  def report
    raise "Please config report mail address!" if @config["report_mail"]["mail_to"].nil? or @config["report_mail"]["mail_from"].nil?

    if @report_body.size > 0
      mail = SimpleMail.new
      mail.to = @config["report_mail"]["mail_to"]
      mail.from = @config["report_mail"]["mail_from"]
      mail.subject = @report_title
      mail.text = @report_body.to_s
      mail.html = @report_body.to_s
      mail.send

      puts "#{self.class.name} report mail sent!"
    else
      puts "#{self.class.name} everything is ok!"
    end
  end
end