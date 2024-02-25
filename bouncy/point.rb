# frozen_string_literal: true

module Bouncy
  # An immutable point in 2-dimensional space.
  class Point
    # @return [Integer]
    attr_reader :x

    # @return [Integer]
    attr_reader :y

    # rubocop:disable Naming/MethodParameterName

    # @param x [Integer]
    # @param y [Integer]
    def initialize(x, y)
      @x = x
      @y = y
    end

    # Alias of {#initialize}.
    def self.[](x, y) = new(x, y)

    # Returns true if +other+ is a +Point+ which is equal to this one,
    # per value equality.
    #
    # @return [Boolean]
    def ==(other)
      other.is_a?(Point) and x == other.x and y == other.y
    end

    alias eql? ==

    # User-friendly string representation of the point.
    #
    # @return [String]
    def to_s
      "(#{x}, #{y})"
    end

    # Value hash of the point object.
    #
    # @return [Integer]
    def hash
      ['Point', x, y].hash
    end

    # @return [Point] The sum of the two points
    def +(other) = Point.new(x + other.x, y + other.y)

    # @return [Point] The difference of the two points
    def -(other) = Point.new(x - other.x, y - other.y)

    # @return [Point] The point-wise modulo of the two points
    def %(other) = Point.new(x % other.x, y % other.y)

    # Identity function on points.
    #
    # @return [Point] self
    def +@ = self

    # @return [Point] The point-wise arithmetic negation of the point
    def -@ = Point.new(-x, -y)

    # @return [Point] North-facing point of Chebyshev length 1.
    def self.north = Point[0, -1]
    # @return [Point] Northeast-facing point of Chebyshev length 1.
    def self.northeast = Point[1, -1]
    # @return [Point] East-facing point of Chebyshev length 1.
    def self.east = Point[1, 0]
    # @return [Point] Southeast-facing point of Chebyshev length 1.
    def self.southeast = Point[1, 1]
    # @return [Point] South-facing point of Chebyshev length 1.
    def self.south = Point[0, 1]
    # @return [Point] Southwest-facing point of Chebyshev length 1.
    def self.southwest = Point[-1, 1]
    # @return [Point] West-facing point of Chebyshev length 1.
    def self.west = Point[-1, 0]
    # @return [Point] Northwest-facing point of Chebyshev length 1.
    def self.northwest = Point[-1, -1]
  end
end

# rubocop:enable Naming/MethodParameterName
