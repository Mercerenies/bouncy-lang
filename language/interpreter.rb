# frozen_string_literal: true

require_relative '../point'
require_relative './pointer'

module Language
  class Interpreter
    attr_reader :grid, :pointer

    def initialize(grid)
      @grid = grid
      @pointer = Pointer.new(grid.find_starting_point)
    end
  end
end
