# frozen_string_literal: true

require_relative './instruction/command'
require_relative './instruction/reflection_command'
require_relative './instruction/mode'

module Bouncy
  # This module contains all of the instructions available in the
  # Bouncy programming language, as well as helpers for working with
  # them.
  module Instruction
    START_TOKEN = '$'

    # Returns a proc which does nothing when called.
    #
    # @return [Proc]
    def self.noop
      proc {}
    end

    # Returns a proc which assigns the given value to the primary
    # register when invoked.
    #
    # @param value [Integer] The constant value to set
    # @return [Proc]
    def self.put_register(value)
      proc do |state|
        state.primary_register = value
      end
    end

    NUMERICAL_COMMANDS = (0..9).map { |i| Command.new(i.to_s, &put_register(i)) }.freeze

    ALL_COMMANDS = (
      [
        # No-ops
        Command.new('$', &noop), # Starting character
        Command.new('.', &noop),
        Command.new(' ', &noop),
        # Control flow
        Command.new('@', &:terminate_program),
        Command.new('#') { |state| state.mode = (state.mode + state.primary_register) % Mode.count },
        ReflectionCommand.new('\\'),
        ReflectionCommand.new('/'),
        ReflectionCommand.new('_'),
        ReflectionCommand.new('|'),
        # Memory
        Command.new('T', &put_register(10)),
        Command.new('S') { |state| state.memory_value = state.primary_register },
        Command.new('L') { |state| state.primary_register = state.memory_value },
        Command.new('(') { |state| state.memory_pointer -= state.primary_register },
        Command.new(')') { |state| state.memory_pointer += state.primary_register },
        Command.new('"', &:swap_registers),
        # Arithmetic
        Command.new('+') { |state| state.primary_register += state.memory_value },
        Command.new('-') { |state| state.primary_register -= state.memory_value },
        Command.new('*') { |state| state.primary_register *= state.memory_value },
        Command.new('%') { |state| state.primary_register /= state.memory_value }, # NOTE: Integer division
        Command.new('m') { |state| state.primary_register = state.primary_register % state.memory_value },
        Command.new('n') { |state| state.primary_register *= -1 },
        Command.new('~') { |state| state.primary_register = boolify(state.primary_register != 0) },
        Command.new('&') { |state| state.primary_register &= state.memory_value },
        Command.new(';') { |state| state.primary_register |= state.memory_value },
        Command.new('^') { |state| state.primary_register ^= state.memory_value },
        # Comparison
        Command.new('<') { |state| state.primary_register = boolify(state.primary_register < state.memory_value) },
        Command.new('=') { |state| state.primary_register = boolify(state.primary_register == state.memory_value) },
        Command.new('>') { |state| state.primary_register = boolify(state.primary_register > state.memory_value) },
        # Input / Output
        Command.new('p') { |state| puts state.primary_register }, # Print as number
        Command.new('P') { |state| print state.primary_register.chr }, # Print as ASCII
        Command.new('i') { |state| state.primary_register = $stdin.gets.to_i }, # Input as number
        Command.new('I') { |state| state.primary_register = $stdin.getch.ord }, # Input as ASCII
      ] + NUMERICAL_COMMANDS
    ).freeze

    COMMANDS_HASH = ALL_COMMANDS.map { |c| [c.name, c] }.to_h

    # A hash of all commands, indexed by their single-character
    # name.
    #
    # @return [Hash<String, Command>]
    def self.commands
      COMMANDS_HASH
    end

    # Returns the command with the given name, or nil if no such
    # command.
    #
    # @return [Command, nil]
    def self.command(name)
      commands[name]
    end

    # Converts the Boolean value to a Bouncy-friendly integer.
    #
    # @param value [Boolean] The input value
    # @return [Integer] 1 if value is true, 0 otherwise
    def self.boolify(value)
      value ? 1 : 0
    end
  end
end
