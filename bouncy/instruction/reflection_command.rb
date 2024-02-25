# frozen_string_literal: true

require_relative './command'
require_relative './reflection_table'

module Bouncy
  module Instruction
    # A command which executes a reflection instruction, per the
    # semantics defined in {ReflectionTable}.
    #
    # When called, a +ReflectionCommand+ will modify the instruction
    # pointer's delta according to the reflection table.
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
