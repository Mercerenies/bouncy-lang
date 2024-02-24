# frozen_string_literal: true

require_relative '../point'
require_relative '../instruction/mode'
require_relative './pointer'
require_relative './data_array'

module Language
  class Interpreter
    attr_reader :grid, :instruction_pointer

    attr_accessor :register_value, :memory_pointer

    def initialize(grid)
      @grid = grid
      @instruction_pointer = Pointer.new(grid.bounds, grid.find_starting_point)
      @data_arrays = Mode.each.map { |mode| [mode, DataArray.new] }.to_h
      @register_value = 0
      @memory_pointer = 0
      @done = false
    end

    def data_array(mode)
      @data_arrays.fetch(mode)
    end

    def terminate_program
      @done = true
    end

    def done?
      @done
    end
  end
end
