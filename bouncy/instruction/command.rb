# frozen_string_literal: true

module Bouncy
  module Instruction
    # A command which is executed on a {Language::Interpreter} object.
    class Command
      # @return [String]
      attr_reader :name

      # Constructs a command from a callable block. The block shall
      # take one argument: the interpreter object.
      #
      # @param name [String] The name of the command
      # @param block [Proc] A one-argument block
      def initialize(name, &block)
        @name = name
        @body = block
      end

      # Invokes the command on the interpreter object.
      #
      # @param interpreter [Language::Interpreter]
      def call(interpreter)
        @body.call interpreter
      end
    end
  end
end
