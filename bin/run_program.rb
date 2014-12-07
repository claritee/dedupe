#!/usr/bin/env ruby

require 'dedupe'
require 'dedupe/application'
require 'dedupe/merger'
require 'dedupe/sorter'
require 'dedupe/version'

application = Dedupe::Application.new({filename: ARGV[0], bucket_size: ARGV[1]})
application.run
