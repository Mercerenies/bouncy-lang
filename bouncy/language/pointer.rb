# frozen_string_literal: true

require_relative '../point'

module Bouncy
  module Language
    # The instruction pointer, which determines where the code is
    # currently at in execution and which way it's moving.
    class Pointer
      # @return [Point] The bounds of the grid
      attr_reader :grid_bounds

      # @return [Point] The current position
      attr_reader :position

      # @return [Point] The amount to change the position by at each step
      attr_accessor :delta

      # @param grid_bounds [Point]
      # @param position [Point]
      # @param delta [Point]
      def initialize(grid_bounds, position, delta = Point[1, 0])
        @grid_bounds = grid_bounds
        @position = position
        @delta = delta
      end

      # @param value [Point]
      def position=(value)
        @position = value % grid_bounds
      end

      # Adds delta to the current position.
      def advance
        self.position += delta
      end
    end
  end
end
