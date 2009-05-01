$LOAD_PATH << './lib'
require 'rubygems'
require 'retrospect'

Retrospect.new
DataMapper.auto_migrate!

run Retrospect::App
