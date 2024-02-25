# frozen_string_literal: true

# rubocop:disable Naming/MethodParameterName
module Bouncy
  class Point
    attr_reader :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def self.[](x, y) = new(x, y)

    def ==(other)
      other.is_a?(Point) and x == other.x and y == other.y
    end

    alias eql? ==

    def to_s
      "(#{x}, #{y})"
    end

    def hash
      ['Point', x, y].hash
    end

    def +(other) = Point.new(x + other.x, y + other.y)
    def -(other) = Point.new(x - other.x, y - other.y)
    def %(other) = Point.new(x % other.x, y % other.y)
    def +@ = self
    def -@ = Point.new(-x, -y)

    def self.north = Point[0, -1]
    def self.northeast = Point[1, -1]
    def self.east = Point[1, 0]
    def self.southeast = Point[1, 1]
    def self.south = Point[0, 1]
    def self.southwest = Point[-1, 1]
    def self.west = Point[-1, 0]
    def self.northwest = Point[-1, -1]
  end
end
# rubocop:enable Naming/MethodParameterName
