# frozen_string_literal: true

require_relative '../point'
require_relative '../instruction'
require_relative '../instruction/mode'
require_relative './pointer'
require_relative './data_array'
require_relative './error'

module Bouncy
  module Language
    class Interpreter
      attr_reader :grid, :instruction_pointer, :debug_mode

      attr_accessor :primary_register, :secondary_register, :memory_pointer, :mode

      def initialize(grid, debug_mode)
        @grid = grid
        @debug_mode = debug_mode
        @instruction_pointer = Pointer.new(grid.bounds, grid.find_starting_point)
        @data_arrays = Instruction::Mode.each.map { |mode| [mode, DataArray.new] }.to_h
        @mode = Instruction::Mode.default
        @primary_register = 0
        @secondary_register = 0
        @memory_pointer = 0
        @done = false
      end

      def data_array(desired_mode)
        @data_arrays.fetch desired_mode
      end

      def terminate_program
        @done = true
      end

      def done?
        @done
      end

      def run_once
        current_char = grid[instruction_pointer.position] || ' '
        command = Instruction.command(current_char)
        raise Error, "Unknown command #{current_char}" unless command

        if debug_mode
          puts(
            "Executing #{current_char} at #{@instruction_pointer.position} " \
            "(mode = #{Instruction::Mode[mode]}, delta = #{instruction_pointer.delta})",
          )
        end
        command.call(self)
        instruction_pointer.advance
      end

      def run
        run_once until done?
      end

      def active_array
        data_array mode
      end

      def memory_value
        active_array[memory_pointer]
      end

      def memory_value=(value)
        active_array[memory_pointer] = value
      end

      def swap_registers
        self.primary_register, self.secondary_register = secondary_register, primary_register
      end
    end
  end
end
