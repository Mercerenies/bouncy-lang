# frozen_string_literal: true

module Bouncy
  module Instruction
    class Command
      attr_reader :name

      def initialize(name, &block)
        @name = name
        @body = block
      end

      def call(interpreter)
        @body.call interpreter
      end
    end
  end
end
