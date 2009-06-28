set :application, "server-monitor"
set :repository,  "git://github.com/hlxwell/server-monitor.git"
set :scm, "git"
set :user, "root"
set :use_sudo, false
set :deploy_to, "/root/server-monitor"

# if ENV["SERVER"]
#   if ENV["SERVER"] == "dev1"
#     set :primary_server, "dev1.asics.eu"
#     set :user, "theplant"
#     set :deploy_to, "/home/theplant/server-monitor"
#   elsif ENV["SERVER"] == "dev2"
#     set :primary_server, "dev1.asics.eu"
#     set :user, "asics"
#     set :deploy_to, "/home/asics/server-monitor"
#   elsif ENV["SERVER"] == "dev3"
#     set :primary_server, "dev3.asics.eu"
#     set :user, "asics"
#     set :deploy_to, "/home/asics/server-monitor"
#   elsif ENV["SERVER"] == "joblet"
#     set :primary_server, "joblet.jp"
#     set :user, "admin"
#     set :deploy_to, "/home/joblet.jp/server-monitor"
#   end
# else
#   set :primary_server, "tui8.com"
#   set :user, "root"
#   set :deploy_to, "/root/server-monitor"
#   set :use_sudo, false
# end

role :new, "magento.tui8.com"
# role :old, "old.tui8.com"