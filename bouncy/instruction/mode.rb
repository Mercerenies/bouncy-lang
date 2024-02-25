# frozen_string_literal: true

module Bouncy
  module Instruction
    # Helpers for working with the different interpreter modes in
    # Bouncy. Note that interpreter modes are simply integers, not
    # instances of a class.
    module Mode
      # The instruction pointer will bounce off of walls.
      BOUNCE = 0
      # The instruction pointer will ignore all walls.
      GHOST = 1
      # The instruction pointer will move parallel to walls.
      ZAP = 2
      # The instruction pointer will move perpendicular to walls.
      FLOW = 3

      # Given an interpreter mode, returns its name.
      #
      # @return [String, nil]
      def self.[](name)
        case name
        when 0 then 'BOUNCE'
        when 1 then 'GHOST'
        when 2 then 'ZAP'
        when 3 then 'FLOW'
        end
      end

      # Returns an array of all modes, in order.
      #
      # @return [Array<Integer>]
      def self.all
        [BOUNCE, GHOST, ZAP, FLOW]
      end

      # @overload each(&block)
      #
      #   Iterates over all modes, in numerical order.
      #
      #   @param block [Proc] the block to execute
      #   @return [Module<Mode>] self
      #
      # @overload each
      #
      #   Returns an enumerator.
      #
      #   @return [Enumerator]
      def self.each(&block)
        if block
          all.each(&block)
          self
        else
          all.each
        end
      end

      # @return The number of distinct modes available
      def self.count
        all.size
      end

      # The mode that every Bouncy program starts in
      def self.default
        BOUNCE
      end
    end
  end
end
