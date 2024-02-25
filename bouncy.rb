# frozen_string_literal: true

require_relative './bouncy/point'
require_relative './bouncy/instruction'
require_relative './bouncy/instruction/mode'
require_relative './bouncy/language/grid'
require_relative './bouncy/language/interpreter'

def execute_program(program_string)
  grid = Bouncy::Language::Grid.load_from_string(program_string)
  if grid.empty? # Prevents division by zero errors when assigning instruction pointer
    grid = Bouncy::Language::Grid.new
    grid[Bouncy::Point[0, 0]] = ' '
  end
  interpreter = Bouncy::Language::Interpreter.new(grid)
  interpreter.run
end

filename = ARGV[0]
raise "Expected filename as argument" unless filename
program_text = File.read(filename).chomp
execute_program program_text
