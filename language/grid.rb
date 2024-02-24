# frozen_string_literal: true

require_relative '../point'
require_relative '../instruction'
require_relative './error'

module Language
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

    def empty?
      @body.empty?
    end

    def bounds
      Point[width, height]
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
      starting_points = each_point.filter { |point| self[point] == Instruction::START_TOKEN }.first
      case starting_points.size
      when 0 then raise Error, 'No starting point ($) found'
      when 1 then starting_points.first
      else raise Error, 'Multiple starting points ($) found'
      end
    end

    def to_s
      @height.times.map do |y|
        @width.times.map do |x|
          self[Point[x, y]] || ' '
        end.join
      end.join("\n")
    end
  end
end
