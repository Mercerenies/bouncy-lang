# frozen_string_literal: true

require_relative '../point'
require_relative '../instruction'
require_relative './error'

module Bouncy
  module Language
    # Two-dimensional dynamically-expanding grid of characters.
    class Grid
      # @return [Integer]
      attr_reader :width

      # @return [Integer]
      attr_reader :height

      def initialize
        @body = {}
        @width = 0
        @height = 0
      end

      # @param point [Point] The index
      # @return [String, nil] The value at that position
      def [](point)
        @body[point]
      end

      # Sets the value at the given position in the grid. Dynamically
      # expands the grid size if needed.
      #
      # @param point [Point] The index
      # @param value [String] The value to set
      def []=(point, value)
        @body[point] = value
        @width = [point.x + 1, @width].max
        @height = [point.y + 1, @height].max
      end

      # Returns true if no positions have been set in this array.
      # Equivalently, returns true if and only if {#width} and
      # {#height} are both zero.
      def empty?
        @body.empty?
      end

      # The bounds of the array, as a {Point}
      #
      # @return [Point]
      def bounds
        Point[width, height]
      end

      # Loads a grid from a newline-delimited string. Each line in the
      # input will be parsed as a row in the grid.
      #
      # @param string [String] The input program
      # @return [Grid]
      def self.load_from_string(string)
        grid = new
        string.split("\n").each.with_index do |line, y|
          line.each_char.with_index do |char, x|
            grid[Point[x, y]] = char
          end
        end
        grid
      end

      # Iterates over the points in the grid, or returns an Enumerator.
      # @overload each_point(&block)
      #   Iterates over the points in row-major order.
      #   @param block [Proc]
      #   @return [Grid] self
      # @overload each_point
      #   Returns an Enumerator for iterating over the
      #   points in row-major order.
      #   @return [Enumerator]
      def each_point(&block)
        if block
          @height.times.each do |y|
            @width.times.each do |x|
              block.call(Point[x, y])
            end
          end
          self
        else
          Enumerator.new { |yielder| each_point(&yielder) }
        end
      end

      # Finds the unique character in the grid equal to
      # {Instruction::START_TOKEN}.
      #
      # @return [Point] The position of the starting token
      # @raise [Error] If there is no starting token or if multiple are found
      def find_starting_point
        starting_points = each_point.filter { |point| self[point] == Instruction::START_TOKEN }
        case starting_points.size
        when 0 then raise Error, 'No starting point ($) found'
        when 1 then starting_points.first
        else raise Error, 'Multiple starting points ($) found'
        end
      end

      # @return [String] A user-friendly representation of the grid
      def to_s
        @height.times.map do |y|
          @width.times.map do |x|
            self[Point[x, y]] || ' '
          end.join
        end.join("\n")
      end
    end
  end
end
