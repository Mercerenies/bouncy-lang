# frozen_string_literal: true

module InstructionMode
  BOUNCE = 0
  GHOST = 1
  ZAP = 2
  FLOW = 3
  MODE_COUNT = 4
end

module Instructions
  START = '$'
end

Point = Data.define(:x, :y) do
  def +(other) = Point.new(x + other.x, y + other.y)
  def -(other) = Point.new(x - other.x, y - other.y)
  def +@ = self
  def -@ = Point.new(-x, -y)
end

class Grid
  attr_reader :width, :height

  def initialize
    @body = {}
    @width = 0
    @height = 0
  end

  def [](point)
    @body[point]
  end

  def []=(point, value)
    @body[point] = value
    @width = [point.x + 1, @width].max
    @height = [point.y + 1, @height].max
  end

  def self.load_from_string(string)
    grid = new
    string.split("\n").each.with_index do |line, y|
      line.each_char.with_index do |char, x|
        grid[Point[x, y]] = char
      end
    end
    grid
  end

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

  def find_starting_point
    starting_points = each_point.filter { |point| self[point] == Instructions::START }.first
    starting_points.first if starting_points.size == 1
  end

  def to_s
    @height.times.map do |y|
      @width.times.map do |x|
        self[Point[x, y]] || ' '
      end.join
    end.join("\n")
  end
end

class InstructionPointer
  attr_accessor :position, :delta

  def initialize(position, delta = Point[1, 0])
    @position = position
    @delta = delta
  end
end

example_program = <<~PROGRAM.chomp
  $...@
  .....
  .....
PROGRAM
grid = Grid.load_from_string(example_program)
puts grid
