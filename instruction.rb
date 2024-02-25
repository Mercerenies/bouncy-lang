# frozen_string_literal: true

require_relative './instruction/command'

module Instruction
  START_TOKEN = '$'

  def self.noop
    proc {}
  end

  def self.put_register(value)
    proc do |state|
      state.register_value = value
    end
  end

  NUMERICAL_COMMANDS = (0..9).map { |i| Command.new(i.to_s, &put_register(i)) }.freeze

  ALL_COMMANDS = (
    [
      # Noops
      Command.new('$', &noop), # Starting character
      Command.new('.', &noop),
      Command.new(' ', &noop),
      # Control flow
      Command.new('@', &:terminate_program),
      # Memory
      Command.new('S') { |state| state.memory_value = state.register_value },
      Command.new('L') { |state| state.register_value = state.memory_value },
      Command.new('>') { |state| state.memory_pointer += state.register_value },
      Command.new('<') { |state| state.memory_pointer -= state.register_value },
      # Arithmetic
      Command.new('+') { |state| state.register_value += state.memory_value },
      Command.new('-') { |state| state.register_value -= state.memory_value },
      Command.new('*') { |state| state.register_value *= state.memory_value },
      Command.new('%') { |state| state.register_value /= state.memory_value }, # NOTE: Integer division
      Command.new('m') { |state| state.register_value = state.register_value % state.memory_value }, # NOTE: Modulo
      Command.new('n') { |state| state.register_value *= -1 },
      Command.new('~') { |state| state.register_value = boolify(state.register_value != 0) },
      Command.new('&') { |state| state.register_value &= state.memory_value },
      Command.new(';') { |state| state.register_value |= state.memory_value },
      Command.new('^') { |state| state.register_value ^= state.memory_value },
      # Comparison
      Command.new('<') { |state| state.register_value = boolify(state.register_value < state.memory_value) },
      Command.new('=') { |state| state.register_value = boolify(state.register_value == state.memory_value) },
      Command.new('>') { |state| state.register_value = boolify(state.register_value > state.memory_value) },
      # Input / Output
      Command.new('p') { |state| puts state.register_value }, # Print as number
      Command.new('P') { |state| print state.register_value.chr }, # Print as ASCII
      Command.new('i') { |state| state.register_value = $stdin.gets.to_i }, # Input as number
      Command.new('I') { |state| state.register_value = $stdin.getch.ord }, # Input as ASCII
    ] + NUMERICAL_COMMANDS
  ).freeze

  COMMANDS_HASH = ALL_COMMANDS.map { |c| [c.name, c] }.to_h

  def self.commands
    COMMANDS_HASH
  end

  def self.command(name)
    commands[name]
  end

  def self.boolify(value)
    if value then 1 else 0 end
  end
end
