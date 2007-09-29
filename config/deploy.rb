#set :application, "screeneur-2"
#set :repository, "http://sd-10743.dedibox.fr/svn/code/ruby/rails/screeneur/trunk/"
#set :deploy_to, "/var/rails/screeneur-2"
#ssh_options[:keys] = ['$HOME/.ssh/id_rsa.pub']
#ssh_options[:verbose] = :debug

require 'mongrel_cluster/recipes'
set :user, 'shingara'
set :application, "screeneur-2"
set :repository, "http://sd-10743.dedibox.fr/svn/code/ruby/rails/screeneur/trunk/"

role :app, "sd-10743.dedibox.fr"
role :web, "sd-10743.dedibox.fr"
role :db, "sd-10743.dedibox.fr", :primary => true

set :deploy_to, "/var/rails/#{application}"

# La configuration de votre cluster Mongrel.
set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"

# Nous indiquons que nous utilisons sudo pour executer des commandes en tant que root
set :use_sudo, true

set :restart_via, :run

#############################
## Liste de tâches à exécuter 
#############################

#Tâche 1
#Réalisée après la création des liens symboliques necessaires.
task :after_symlink, :roles => [:web, :app] do
    # Changer l'environnement de développement à production
    run "perl -i -pe \"s/# ENV\\['RAILS_ENV'\\] \\|\\|= 'production'/ENV['RAILS_ENV'] ||= 'production'/\" #{current_path}/config/environment.rb"

    # Conserver le même répertoire tmp qu'avant le déploiement, création de liens sympliques
    run "rm -drf #{current_path}/tmp"
    run "ln -s #{shared_path}/tmp #{current_path}/tmp"
end

#Tâche 2
#Exemple d'une tâche qui fait en sorte de conserver les même répertoire rep1 et rep2 avant et après déploiement
#Utile pour un répertoire d'images uploadées par exemple.
# task :after_update_code do
#  %w{rep1 rep2}.each do |share|
#  run "rm -drf #{release_path}/public/#{share}"
#    run "ln -s #{shared_path}/#{share} #{release_path}/public/#{share}"
#  end
#end
