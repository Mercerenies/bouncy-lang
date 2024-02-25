# frozen_string_literal: true

module Bouncy
  module Language
    # Random access integer-indexed data structure that's infinite in
    # both directions and assumes all uninitialized values are zero.
    class DataArray
      def initialize
        @impl = {}
      end

      def [](index)
        @impl.fetch(index, 0)
      end

      def []=(index, value)
        raise TypeError, 'Value must be numeric' unless value.is_a? Numeric

        @impl[index] = value
      end
    end
  end
end
