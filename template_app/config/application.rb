Perc.app = Perc::Application.new(
  root: Pathname.new(File.expand_path('../..', __FILE__)),
  env: ENV.fetch('PERC_ENV', 'development')
)

require_relative 'environment'
