# frozen_string_literal: true

require_relative '../point'

module Language
  class Pointer
    attr_accessor :position, :delta

    def initialize(position, delta = Point[1, 0])
      @position = position
      @delta = delta
    end
  end
end
