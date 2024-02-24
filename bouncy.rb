# frozen_string_literal: true

require_relative './instruction'
require_relative './instruction/mode'
require_relative './language/grid'

example_program = <<~PROGRAM.chomp
  $...@
  .....
  .....
PROGRAM
grid = Language::Grid.load_from_string(example_program)
puts grid
