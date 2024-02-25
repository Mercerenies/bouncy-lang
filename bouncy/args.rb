# frozen_string_literal: true

require 'optparse'

module Bouncy
  # Command line arguments structure. Stores the result of parsing
  # ARGV.
  class Args
    # Error raised when the required input filename argument is not
    # supplied, or when multiple input filenames are supplied.
    class ExpectedFilenameError < StandardError
      def initialize
        super('Expected filename')
      end
    end

    # Whether or not debug output should be emitted for each step of
    # the run.
    #
    # @return [Boolean]
    attr_accessor :debug_mode

    # The input filename to be executed.
    #
    # @return [String]
    attr_accessor :filename

    def initialize
      @debug_mode = false
      @filename = nil
    end

    # Defines the command line switches on the given parser object.
    #
    # Most callers will prefer to invoke {.parse} instead, which
    # delegates to this method.
    #
    # @param parser [OptionParser]
    def define_options(parser)
      parser.on('-d', '--[no-]debug', 'Run with debugging output') do |d|
        self.debug_mode = d
      end
    end

    # Parses the command line arguments and returns a new +Args+
    # object.
    #
    # @param argv [Array<String>] The command line arguments to be parsed
    # @return [Args] The parsed command line arguments
    # @raise [ExpectedFilenameError]
    # @raise [OptionParser::InvalidOption]
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
