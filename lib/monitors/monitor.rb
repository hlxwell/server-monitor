require 'yaml'
class Monitor

  def initialize
    @report_title = ""
    @report_body = []
    @config = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '../../../config/monitor_config.yml'))
    @monitor_config = @config["monitors"][self.class.name]
  end

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