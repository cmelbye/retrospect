require 'haml'
require 'dm-core'
require 'dm-validations'
require 'dm-types'
require 'dm-timestamps'
require 'dm-aggregates'
require 'sinatra/base'

require 'logger'
require 'sass'

require 'retrospect/core_ext/object'
require 'retrospect/helpers'
require 'retrospect/app'
require 'retrospect/project'

module Retrospect
  def self.new(config=nil)
    if config.is_a?(String) && File.find?(config)
      self.config = YAML.load_file(config)
    elsif config.is_a?(Hash)
      self.config = config
    end
    
    DataMapper.setup(:default, self.config[:database_uri])
  end
  
  def self.default_configuration
    @defaults ||= { :database_uri       => "sqlite3::memory:",
                    :export_directory   => "/tmp/exports",
                    :log                => STDOUT,
                    :base_uri           => "http://localhost:3000" }
  end
  
  def self.config
    @config ||= default_configuration.dup
  end
  
  def self.config=(options)
    @config = default_configuration.merge(options)
  end
  
  def self.log(message, &block)
    logger.info(message, &block)
  end
  
  def self.logger
    @logger ||= Logger.new(config[:log], "daily").tap do |logger|
      logger.formatter = LogFormatter.new
    end
  end
  private_class_method :logger
  
  class LogFormatter < Logger::Formatter
    def call(severity, time, progname, msg)
      time.strftime("[%H:%M:%S] ") + msg2str(msg) + "\n"
    end
  end
end