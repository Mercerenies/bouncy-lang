# frozen_string_literal: true

module Bouncy
  module Language
    # Random access integer-indexed data structure that's infinite in
    # both directions and assumes all uninitialized values are zero.
    class DataArray
      def initialize
        @impl = {}
      end

      # @param index [Integer] The index into the array
      #
      # @return [Integer] The value at the given index, or 0 if
      # uninitialized
      def [](index)
        @impl.fetch(index, 0)
      end

      # @param index [Integer] The index into the array
      # @param value [Integer] The new value
      #
      # @return [Integer] The new value
      def []=(index, value)
        raise TypeError, 'Value must be an integer' unless value.is_a? Integer

        @impl[index] = value
      end
    end
  end
end
