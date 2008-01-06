
desc "Generate the maintenance page in public directory"
task :maintenance => :environment do
  Map.new.show_maintenance
end

desc "hide the maintenance page in public directory"
task :hide_maintenance => :environment do
  Map.new.hide_maintenance
end
