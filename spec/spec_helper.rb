require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'rubygems'
require 'bundler/setup'
Bundler.require(:development)

require 'date'
require 'pry'
require 'identified'
