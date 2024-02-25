#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './bouncy/point'
require_relative './bouncy/args'
require_relative './bouncy/instruction'
require_relative './bouncy/instruction/mode'
require_relative './bouncy/language/grid'
require_relative './bouncy/language/interpreter'

def execute_program(program_string, debug_mode)
  grid = Bouncy::Language::Grid.load_from_string(program_string)
  if grid.empty? # Prevents division by zero errors when assigning instruction pointer
    grid = Bouncy::Language::Grid.new
    grid[Bouncy::Point[0, 0]] = ' '
  end
  interpreter = Bouncy::Language::Interpreter.new(grid, debug_mode)
  interpreter.run
end

args = Bouncy::Args.parse
program_text = File.read(args.filename).chomp
execute_program program_text, args.debug_mode
