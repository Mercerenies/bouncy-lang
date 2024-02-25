# frozen_string_literal: true

require_relative './point'
require_relative './instruction'
require_relative './instruction/mode'
require_relative './language/grid'
require_relative './language/interpreter'

def execute_program(program_string)
  grid = Language::Grid.load_from_string(program_string)
  if grid.empty? # Prevents division by zero errors when assigning instruction pointer
    grid = Language::Grid.new
    grid[Point[0, 0]] = ' '
  end
  interpreter = Language::Interpreter.new(grid)
  interpreter.run
end

example_program = <<~PROGRAM.chomp
  $1S2+p@
  .....
  .....
PROGRAM
execute_program example_program
