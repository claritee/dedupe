#!/usr/bin/env ruby

require 'dedupe'
require 'dedupe/application'

application = Dedupe::Application.new({filename: ARGV[0], bucket_size: ARGV[1]})
application.run
