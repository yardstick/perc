require 'perc'
require 'thor'

module Perc
  class Cli < Thor
    desc 'console', 'Get access to a console with your environment loaded'
    def console
      ARGV.shift # so irb doesn't explode
      require 'irb'
      IRB.start(Perc.app.root)
    end
  end
end
