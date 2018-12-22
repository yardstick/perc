require 'active_support'
require 'active_support/core_ext'

module Perc

  module Config
    Optional = false
  end
  ##
  # Class for holding stuff you might find in a typical application
  class Application
    LoggerLevels = {
      'DEBUG' => Logger::DEBUG,
      'INFO' => Logger::INFO,
      'WARN' => Logger::WARN,
      'ERROR' => Logger::ERROR
    }

    class Config
      class FileMissingError < StandardError; end
      class EnvironmentMissingError < StandardError; end

      attr_accessor :autoload_paths

      def initialize
        @autoload_paths = []
      end
    end

    attr_reader :root, :env, :logger

    delegate :development?, :production?, :test?, to: :env

    def initialize(options)
      @root = options.fetch(:root)
      @env = ActiveSupport::StringInquirer.new(options.fetch(:env))
      config do |c|
        Dir[root.join('app', '*')].each do |d|
          c.autoload_paths << d.to_s
        end
      end
    end

    def env=(string)
      @env = ActiveSupport::StringInquirer.new(string)
    end

    def load_rake
      rake_files = Dir[File.expand_path('../tasks/*.rake', __FILE__)] +
        Dir[root.join('lib/tasks/*.rake')]

      rake_files.each do |f|
        load(f)
      end
    end

    def config_for(thing, required = true)
      file = root.join('config', "#{thing}.yml")
      if file.exist?
        require 'yaml'
        require 'erb'
        thing_parsed = (YAML.load(ERB.new(file.read).result) || {})[env]
        return (thing_parsed and thing_parsed.with_indifferent_access) unless (thing_parsed.nil? && required)
        raise Config::EnvironmentMissingError, "config_for(#{thing}) nil for env: #{env}"
      else
        raise Config::FileMissingError, "Could not load configuration. No such file: #{file}"
      end
    end

    def boot
      initialize_logging
      setup_autoload_directories
      require_environment
      run_initializers
    end

    def config
      @config ||= Config.new
      yield(@config) if block_given?
      @config
    end

    def commands
      require 'perc/cli_wrapper'
      cli = CliWrapper.new
      yield(cli) if block_given?
      cli
    end

  private

    def run_initializers
      Dir[root.join('config', 'initializers', '*.rb')].each do |f|
        require f
      end
    end

    def setup_autoload_directories
      ActiveSupport::Dependencies.autoload_paths = config.autoload_paths
    end

    def initialize_logging
      @logger = Logger.new(test? ? 'log/test.log' : STDERR)
      @logger.level = LoggerLevels[ENV.fetch('PERC_LOG_LEVEL', 'DEBUG')]
    end

    def require_environment
      require root.join('config', 'environments', env).to_s
    end
  end
end
