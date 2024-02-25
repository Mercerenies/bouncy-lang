# frozen_string_literal: true

require_relative '../point'
require_relative '../instruction'
require_relative '../instruction/mode'
require_relative './pointer'
require_relative './data_array'
require_relative './error'

module Bouncy
  module Language
    # The interpreter and accompanying state for an execution of a
    # Bouncy program.
    class Interpreter
      # @return [Grid]
      attr_reader :grid

      # @return [Pointer]
      attr_reader :instruction_pointer

      # @return [Boolean] Whether or not debug mode is enabled
      attr_reader :debug_mode

      # @return [Integer]
      attr_accessor :primary_register

      # @return [Integer]
      attr_accessor :secondary_register

      # @return [Integer]
      attr_accessor :memory_pointer

      # @return [Integer] A constant from {Instruction::Mode}
      attr_accessor :mode

      # @param grid [Grid]
      # @param debug_mode [Boolean]
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

      # Returns the data array associated with the given mode.
      #
      # @param desired_mode [Integer] a constant from {Instruction::Mode}
      # @return [DataArray]
      # @raise [KeyError] If the mode is not recognized
      def data_array(desired_mode)
        @data_arrays.fetch desired_mode
      end

      # Sets the terminate flag to true to indicate that the
      # interpreter is done executing the program.
      def terminate_program
        @done = true
      end

      # True if the interpreter should stop executing this program.
      def done?
        @done
      end

      # Runs one step of the program. This method shall not be called
      # if {#done?} is true.
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

      # Runs the program to completion. After this method is called,
      # {#done?} shall return true.
      def run
        run_once until done?
      end

      # Returns the active data array.
      #
      # @return [DataArray]
      def active_array
        data_array mode
      end

      # Returns the value of the active memory cell.
      #
      # @return [Integer]
      def memory_value
        active_array[memory_pointer]
      end

      # Sets the value of the active memory cell.
      #
      # @param value [Integer]
      def memory_value=(value)
        active_array[memory_pointer] = value
      end

      # Swaps the values of the primary and secondary registers.
      def swap_registers
        self.primary_register, self.secondary_register = secondary_register, primary_register
      end
    end
  end
end
