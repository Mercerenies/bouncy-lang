# frozen_string_literal: true

require_relative './instruction/command'

module Instruction
  START_TOKEN = '$'

  def self.noop
    proc {}
  end

  ALL_COMMANDS = [
    Command.new('$', &noop),
    Command.new('.', &noop),
    Command.new(' ', &noop),
    Command.new('@', &:terminate_program),
  ].freeze

  COMMANDS_HASH = ALL_COMMANDS.map { |c| [c.name, c] }.to_h

  def self.commands
    COMMANDS_HASH
  end

  def self.command(name)
    commands[name]
  end
end
