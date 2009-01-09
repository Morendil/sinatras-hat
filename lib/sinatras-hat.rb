$LOAD_PATH << File.join(File.dirname(__FILE__))

require 'rubygems'
require 'sinatra/base'
require 'extlib'

require 'core_ext/array'
require 'core_ext/hash'
require 'core_ext/object'
require 'core_ext/module'

require 'sinatras-hat/extendor'
require 'sinatras-hat/hash_mutator'
require 'sinatras-hat/resource'
require 'sinatras-hat/response'
require 'sinatras-hat/responder'
require 'sinatras-hat/router'
require 'sinatras-hat/model'
require 'sinatras-hat/maker'
require 'sinatras-hat/actions'
