# frozen_string_literal: true

Point = Data.define(:x, :y) do
  def +(other) = Point.new(x + other.x, y + other.y)
  def -(other) = Point.new(x - other.x, y - other.y)
  def %(other) = Point.new(x % other.x, y % other.y)
  def +@ = self
  def -@ = Point.new(-x, -y)
end
