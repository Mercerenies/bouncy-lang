# frozen_string_literal: true

require_relative '../point'

module Bouncy
  module Language
    class Pointer
      attr_reader :grid_bounds, :position
      attr_accessor :delta

      def initialize(grid_bounds, position, delta = Point[1, 0])
        @grid_bounds = grid_bounds
        @position = position
        @delta = delta
      end

      def position=(value)
        @position = value % grid_bounds
      end

      def advance
        self.position += delta
      end
    end
  end
end
