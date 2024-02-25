# frozen_string_literal: true

module Bouncy
  Point = Data.define(:x, :y) do
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
