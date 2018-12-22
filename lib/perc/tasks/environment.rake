task :environment do
  Perc.app.env = ENV['PERC_ENV']
  Perc.app.boot
end
