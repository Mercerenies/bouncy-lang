# frozen_string_literal: true

require 'optparse'

module Bouncy
  class Args
    class ExpectedFilenameError < StandardError
      def initialize
        super('Expected filename')
      end
    end

    attr_accessor :debug_mode, :filename

    def initialize
      @debug_mode = false
      @filename = nil
    end

    def define_options(parser)
      parser.on('-d', '--[no-]debug', 'Run with debugging output') do |d|
        self.debug_mode = d
      end
    end

    def self.parse(argv = ARGV)
      args = new
      OptionParser.new do |parser|
        parser.banner = 'bouncy.rb [options...] <filename>'
        args.define_options parser
        parser.parse!(argv)
      end
      raise ExpectedFilenameError unless argv.length == 1

      args.filename = argv[0]
      args
    end
  end
end
