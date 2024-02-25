#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './bouncy/point'
require_relative './bouncy/args'
require_relative './bouncy/instruction'
require_relative './bouncy/instruction/mode'
require_relative './bouncy/language/grid'
require_relative './bouncy/language/interpreter'

# Top-level namespace for the Bouncy programming language.
module Bouncy
end

# Runs the program given by the string +program_string+.
#
# @param program_string [String] The program to run
# @param debug_mode [Boolean] Whether to print debug messages
def execute_program(program_string, debug_mode)
  grid = Bouncy::Language::Grid.load_from_string(program_string)
  if grid.empty? # Prevents division by zero errors when assigning instruction pointer
    grid = Bouncy::Language::Grid.new
    grid[Bouncy::Point[0, 0]] = ' '
  end
  interpreter = Bouncy::Language::Interpreter.new(grid, debug_mode)
  interpreter.run
end

# Parses command line arguments. If command line parsing fails, prints
# an error and then exits.
#
# @return [Bouncy::Args]
def parse_args
  Bouncy::Args.parse
rescue OptionParser::InvalidOption, Bouncy::Args::ExpectedFilenameError
  warn "Error: #{$!.message}"
  exit 1
end

args = parse_args
program_text = File.read(args.filename).chomp
execute_program program_text, args.debug_mode
