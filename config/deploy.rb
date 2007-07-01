set :application, "screeneur"
set :repository, "http://sd-10743.dedibox.fr/svn/code/ruby/rails/screeneur/trunk/"
role :app, "sd-10743.dedibox.fr"
role :web, "sd-10743.dedibox.fr"
role :db, "sd-10743.dedibox.fr"
set :deploy_to, "/var/rails/screeneur"
ssh_options[:keys] = ['$HOME/.ssh/id_rsa.pub']
ssh_options[:verbose] = :debug
