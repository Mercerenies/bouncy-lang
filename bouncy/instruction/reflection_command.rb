# frozen_string_literal: true

require_relative './command'
require_relative './reflection_table'

module Bouncy
  module Instruction
    class ReflectionCommand < Command
      def initialize(name)
        super(name) do |state|
          state.instruction_pointer.delta = ReflectionTable.evaluate(
            state.mode,
            name,
            state.instruction_pointer.delta,
          )
        end
      end
    end
  end
end
