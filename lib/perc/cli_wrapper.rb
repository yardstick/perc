require 'perc/cli'

module Perc
  class CliWrapper
    delegate :desc, to: 'Perc::Cli'

    def command(name, &block)
      Cli.send(:define_method, name, &block)
    end
  end
end
