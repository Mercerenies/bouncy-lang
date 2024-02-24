# frozen_string_literal: true

require_relative './point'
require_relative './instruction'
require_relative './instruction/mode'
require_relative './language/grid'
require_relative './language/interpreter'

example_program = <<~PROGRAM.chomp
  $...@
  .....
  .....
PROGRAM
grid = Language::Grid.load_from_string(example_program)
if grid.empty? # Prevents division by zero errors when assigning instruction pointer
  grid = Language::Grid.new
  grid[Point[0, 0]] = ' '
end
puts grid
